/**
 * Nombre del Programa : GenericAction.java                                    
 * Autor: Vladimir Aguirre Piedragil
 * Compania: Ultrasist                                                
 * Proyecto: NSJP 
 * Fecha: 29 Mar 2011 
 * Marca de cambio: N/A                                                     
 * Descripcion General: Action gen�rico del que deben extender todos los actions de la aplicaci�n y poder agrupar funcionalidad com�n.(DRY).
 * Programa Dependiente: N/A                                                      
 * Programa Subsecuente: N/A                                                      
 * Cond. de ejecucion: N/A                                                      
 * Dias de ejecucion: N/A                             Horario: N/A       
 *                              MODIFICACIONES                                       
 *------------------------------------------------------------------------------           
 * Autor                       :N/A                                                           
 * Compania               :N/A                                                           
 * Proyecto                 :N/A                                   Fecha: N/A       
 * Modificacion           :N/A                                                           
 *------------------------------------------------------------------------------           
 */
package mx.gob.segob.nsjp.web.base.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mx.gob.segob.nsjp.comun.enums.calidad.Calidades;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.comun.util.tl.PaginacionThreadHolder;
import mx.gob.segob.nsjp.delegate.catalogo.CatalogoDelegate;
import mx.gob.segob.nsjp.dto.base.PaginacionDTO;
import mx.gob.segob.nsjp.dto.configuracion.ConfiguracionDTO;
import mx.gob.segob.nsjp.dto.expediente.DelitoDTO;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.involucrado.InvolucradoDTO;
import mx.gob.segob.nsjp.dto.usuario.UsuarioDTO;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.apache.struts.actions.MappingDispatchAction;
import org.springframework.beans.factory.annotation.Autowired;

import com.thoughtworks.xstream.XStream;

/**
 * @author vaguirre
 * 
 */
public abstract class GenericAction extends MappingDispatchAction {
    private static final Logger logger = Logger.getLogger(GenericAction.class);
    /** Clase para la conversion de los objetos a xml */

    private final static String KEY_SESSION_EXPEDIENTE_TRABAJO = "KEY_SESSION_EXPEDIENTE_TRABAJO";
    public final static String KEY_SESSION_USUARIO_FIRMADO = "KEY_SESSION_USUARIO_FIRMADO";
    public final static String KEY_SESSION_CONFIGURACION_GLOBAL = "KEY_SESSION_CONFIGURACION_GLOBAL";
    //URG-005 Turno
    public final static String KEY_SESSION_HABILITAR_TURNO = "KEY_SESSION_HABILITAR_TURNO";

    public final static String KEY_SESSION_ACTION_LOCALE = "org.apache.struts.action.LOCALE";
    // Menu izquierdo, se generara dinamicamente 
    public final static String KEY_SESSION_MENU_DINAMICO_DERECHO = "KEY_SESSION_MENU_DINAMICO_DERECHO";
    public final static String KEY_SESSION_MENU_DINAMICO_SUPERIOR = "KEY_SESSION_MENU_DINAMICO_SUPERIOR";
    public final static String KEY_SESSION_MENU_DINAMICO_IZQUIERDO = "KEY_SESSION_MENU_DINAMICO_IZQUIERDO";
    
    @Autowired
    protected XStream converter;

    @Autowired
    protected CatalogoDelegate catDelegate;

    /**
     * Escribe el XML de la respuesta en el response.
     * 
     * @param response
     *            Objeto <code>HttpServletResponse</code> donde se escribir� la
     *            respuesta.
     * @param xml
     *            Respuesta.
     */
    protected void escribirRespuesta(HttpServletResponse response, String xml) {
        this.escribir(response, xml, null);
    }

    /**
     * Escribe el XML de con le mesaje de error en el response.
     * 
     * @param response
     *            Objeto <code>HttpServletResponse</code> donde se escribir� la
     *            respuesta.
     * @param ex
     *            Excepci�n ocurrida.
     */
    protected void escribirError(HttpServletResponse response,
            NSJPNegocioException ex) {
        this.escribir(response, null, ex);
    }
    /**
     * 
     * @param response
     *            Objeto <code>HttpServletResponse</code> donde se escribir� la
     *            respuesta.
     * @param xml
     *            Respuesta.
     * @param ex
     *            Excepci�n ocurrida.
     */
    protected void escribir(HttpServletResponse response, String xml,
            NSJPNegocioException ex) {

        final StringBuffer buf = new StringBuffer();
        buf.append("<response>");
        if (ex == null) {
            buf.append("<code>0</code>");
            buf.append("<message></message>");
        } else {
            buf.append("<code>");
            buf.append(ex.getCodigo());
            buf.append("</code>");
            buf.append("<message>");
            buf.append(ex.getMessage());
            buf.append("</message>");
        }
        buf.append("<body>");
        buf.append(xml);
        buf.append("</body>");
        buf.append("</response>");
        PrintWriter pWriter = null;
        try {
            response.setContentType("text/xml");
            pWriter = response.getWriter();
            pWriter.print(buf);
            pWriter.flush();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (pWriter != null) {
                pWriter.close();
            }
        }

    }

    /**
     * Obtiene el usuario firmado en la aplicaci�n.
     * 
     * @return Usuario obtenido de la sesion, <code>null</code> en caso de que
     *         no exista un usuario firmado.
     */
    protected UsuarioDTO getUsuarioFirmado(HttpServletRequest request) {
        HttpSession ses = request.getSession();

        UsuarioDTO usrFromSess = (UsuarioDTO) ses
                .getAttribute(KEY_SESSION_USUARIO_FIRMADO);

        if (usrFromSess == null) {
            return null;
        }
        if (usrFromSess.getAreaActual() == null) {
            usrFromSess.setAreaActual(usrFromSess.getArea());
        }
        return usrFromSess;
    }
    /**
     * Recupera la configuraci�n global
     * @param request
     * @return
     */
    protected ConfiguracionDTO getConfguracionGlobal(HttpServletRequest request) {
        HttpSession ses = request.getSession();
        ConfiguracionDTO cfgFromSess = (ConfiguracionDTO) ses
                .getAttribute(KEY_SESSION_CONFIGURACION_GLOBAL);
        return cfgFromSess;
    }

    /**
     * Obtiene el expediete de trabajo.
     * 
     * @return Expediente obtenido de sesion, <code>null</code> en caso de que
     *         no exista.
     */
    protected ExpedienteDTO getExpedienteTrabajo(HttpServletRequest request,
            String numeroUnicoExpediente) {
        HttpSession ses = request.getSession();
        ExpedienteDTO fromSes = (ExpedienteDTO) ses
                .getAttribute(KEY_SESSION_EXPEDIENTE_TRABAJO
                        + numeroUnicoExpediente);
        if (fromSes != null) {
            logger.debug("Obteniendo de session :: "
                    + fromSes.getNumeroExpediente() + " con numeroExpedienteId = " + fromSes.getNumeroExpedienteId());
            return fromSes;
        }
        return null;
    }

    /**
     * Remueve el expediente de trabajo.
     * 
     * @return Expediente obtenido de sesion, <code>null</code> en caso de que
     *         no exista.
     */
    protected void eliminarExpedienteTrabajo(HttpServletRequest request,
            String numeroUnicoExpediente) {
        HttpSession ses = request.getSession();
        ses.removeAttribute(KEY_SESSION_EXPEDIENTE_TRABAJO
                + numeroUnicoExpediente);
    }

    /**
     * Sube a sesi�n el expediente de trabajo, usa como llave la propiedad:
     * <code>numeroExpediente</code>.
     * 
     * @param request
     * @param exp
     */
    protected void setExpedienteTrabajo(HttpServletRequest request,
            ExpedienteDTO exp) {
        logger.debug("Poniendo en session :: " + exp.getNumeroExpediente());
        HttpSession ses = request.getSession();
        ses.setAttribute(
                KEY_SESSION_EXPEDIENTE_TRABAJO + exp.getNumeroExpediente(), exp);
    }
    /**
     * Conviert eun String a Long.
     * 
     * @param val
     * @return Si es nulo o no es numerico regresa nulo, en caso contrario
     *         regresa el valor numerico representado en la cadena
     */
    protected Long parseLong(String val) {
        if (val == null || !NumberUtils.isNumber(val)) {
            return null;
        }
        return Long.parseLong(val);
    }
    /**
     * Valida que la cadena no apunte a la referencia <code>null</code>, est�
     * vac�a o contenga la palabra null (ignorando may�sculas o min�sculas).<br>
     * isNotBlank(null) = <code>false</code><br>
     * isNotBlank("") = <code>false</code><br>
     * isNotBlank(" ") = <code>false</code><br>
     * isNotBlank("null") = <code>false</code><br>
     * isNotBlank("NULL") = <code>false</code><br>
     * isNotBlank("hola") = <code>true</code><br>
     * isNotBlank("  hola  ") = <code>true</code>
     * 
     * @param val
     * @return
     */
    protected boolean isNotBlank(String val) {
        return (StringUtils.isNotBlank(val) && val.equalsIgnoreCase("null"));
    }
    
    /**
     * Metodo que construye el XML para mostrarse en los girds de PJ admonPj y encargado sala
     * @param listaInvolucrados
     * @param response
     * @throws IOException
     */
	protected void escribeXmlInvolucradosAudiencia(
			List<InvolucradoDTO> listaInvolucrados, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/xml; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter writer = response.getWriter();

		writer.print("<rows>");

		final PaginacionDTO pag = PaginacionThreadHolder.get();

		if (pag != null && pag.getTotalRegistros() != null) {
			writer.print("<total>" + pag.getTotalPaginas() + "</total>");
			writer.print("<records>" + pag.getTotalRegistros() + "</records>");
		} else {
			writer.print("<total>0</total>");
			writer.print("<records>0</records>");
		}

		for (InvolucradoDTO involucrado : listaInvolucrados) {

			if (involucrado.getCalidadDTO() != null
					&& involucrado.getCalidadDTO().getCalidades() != null
					&& involucrado.getCalidadDTO().getCalidades().getValorId() != null) {

				writer.print("<row id='" + involucrado.getElementoId() + "'>");
				writer.print("<cell>"
						+ (involucrado.getNombreCompleto() != null ? involucrado
								.getNombreCompleto() : "") + "</cell>");

				// Obtenemos el id de la calidad
				Long calidadId = involucrado.getCalidadDTO().getCalidades()
						.getValorId();

				if (calidadId.equals(Calidades.DENUNCIANTE.getValorId())
						&& involucrado.getCondicion() != null
						&& involucrado.getCondicion().equals(new Short("1"))) {
					writer.print("<cell>" + "V&#237;ctima y Denunciante"
							+ "</cell>");

				} else {
					writer.print("<cell>"
							+ ((involucrado.getCalidadDTO().getValorIdCalidad() != null && involucrado
									.getCalidadDTO().getValorIdCalidad()
									.getValor() != null) ? involucrado
									.getCalidadDTO().getValorIdCalidad()
									.getValor() : "") + "</cell>");
				}

				if (calidadId.equals(Calidades.PROBABLE_RESPONSABLE_PERSONA
						.getValorId())
						|| calidadId
								.equals(Calidades.PROBABLE_RESPONSABLE_ORGANIZACION
										.getValorId())) {

					List<DelitoDTO> listaDelitos = involucrado
							.getDelitosCometidos();

					// Combo box de delitos
					if (listaDelitos == null || listaDelitos.isEmpty()) {
						writer.print("<cell><![CDATA[<select id='cbxDelitos' style='width: 150px;' disabled='disabled'><option>"
								+ "Sin delito</option></select>]]></cell>");
					} else {
						writer.print("<cell><![CDATA["
								+ "<select id='cbxDelitos' style='width: 150px;'>");
						for (DelitoDTO delito : listaDelitos) {
							writer.print("<option>" + delito.getCatDelitoDTO().getNombre()
									+ "</option>");
						}
						writer.print("</select>" + "]]></cell>");
					}

					// Check box de detenido
					if (involucrado.getEsDetenido() != null
							&& involucrado.getEsDetenido()) {
						writer.print("<cell>"
								+ "<![CDATA[<input type='checkbox' checked='checked' disabled='disabled'>]]>"
								+ "</cell>");
					} else {
						writer.print("<cell>"
								+ "<![CDATA[<input type='checkbox' disabled='disabled'>]]>"
								+ "</cell>");
					}

				} else {
					writer.print("<cell></cell>");
					writer.print("<cell></cell>");
				}
				writer.print("</row>");
			}
		}
		writer.print("</rows>");
		writer.flush();
		writer.close();
	}
}
