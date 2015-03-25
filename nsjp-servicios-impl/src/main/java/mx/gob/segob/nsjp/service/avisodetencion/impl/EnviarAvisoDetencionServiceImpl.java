/**
 * Nombre del Programa : EnviarAvisoDetencionServiceImpl.java
 * Autor                            : vaguirre
 * Compania                    : Ultrasist
 * Proyecto                      : NSJP                    Fecha: 8 Aug 2011
 * Marca de cambio        : N/A
 * Descripcion General    : Servicio par aenviar el aviso de detención.
 * Programa Dependiente  :N/A
 * Programa Subsecuente :N/A
 * Cond. de ejecucion        :N/A
 * Dias de ejecucion          :N/A                             Horario: N/A
 *                              MODIFICACIONES
 *------------------------------------------------------------------------------
 * Autor                       :N/A
 * Compania               :N/A
 * Proyecto                 :N/A                                 Fecha: N/A
 * Modificacion           :N/A
 *------------------------------------------------------------------------------
 */
package mx.gob.segob.nsjp.service.avisodetencion.impl;

import java.util.Date;

import mx.gob.segob.nsjp.comun.enums.documento.EstatusNotificacion;
import mx.gob.segob.nsjp.comun.enums.documento.TipoDocumento;
import mx.gob.segob.nsjp.comun.enums.excepciones.CodigoError;
import mx.gob.segob.nsjp.comun.enums.forma.Formas;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dao.avisodetencion.AvisoDetencionDAO;
import mx.gob.segob.nsjp.dao.institucion.ConfInstitucionDAO;
import mx.gob.segob.nsjp.dao.involucrado.DetencionDAO;
import mx.gob.segob.nsjp.dao.involucrado.InvolucradoDAO;
import mx.gob.segob.nsjp.dto.caso.CasoDTO;
import mx.gob.segob.nsjp.dto.documento.AvisoDetencionDTO;
import mx.gob.segob.nsjp.dto.involucrado.DetencionDTO;
import mx.gob.segob.nsjp.model.AvisoDetencion;
import mx.gob.segob.nsjp.model.ConfInstitucion;
import mx.gob.segob.nsjp.model.Detencion;
import mx.gob.segob.nsjp.model.Forma;
import mx.gob.segob.nsjp.model.Involucrado;
import mx.gob.segob.nsjp.model.Valor;
import mx.gob.segob.nsjp.service.avisodetencion.EnviarAvisoDetencionService;
import mx.gob.segob.nsjp.service.infra.DefensoriaClienteService;
import mx.gob.segob.nsjp.service.involucrado.impl.transform.InvolucradoTransformer;
import mx.gob.segob.nsjp.service.solicitud.GenerarFolioSolicitudService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Servicio par aenviar el aviso de detención.
 *
 * @version 1.0
 * @author vaguirre
 *
 */
@Service
@Transactional
public class EnviarAvisoDetencionServiceImpl
        implements
            EnviarAvisoDetencionService {

    /**
     * Logger.
     */
    private final static Logger logger = Logger
            .getLogger(EnviarAvisoDetencionServiceImpl.class);


    @Autowired
    private ConfInstitucionDAO confInsDao;

    @Autowired
    private DetencionDAO detencionDao;

    @Autowired
    private InvolucradoDAO involucradoDAO;

    @Autowired
    private DefensoriaClienteService clienteWs;

    @Autowired
    private GenerarFolioSolicitudService generarFolioSolicitudService;
    @Autowired
    private AvisoDetencionDAO avisoDao;

    @Override
    public void enviarAvisoDetencion(DetencionDTO input,Long idAgencia, String claveAgencia, Long idFuncionarioSolicitante)
            throws NSJPNegocioException {
    	
    	boolean flagDetencion = false;

        System.out.print("Inicia - enviarAvisoDetencion(...)");
        System.out.print("input.getFechaRecepcionDetencion() :: " + input.getFechaRecepcionDetencion());
        System.out.print("*************** VALIDA INVOLUCRADO ***************");
        if (input == null || input.getInvolucradoDTO() == null) {
            throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);
        }
        System.out.print("*************** verificacion de aviso ***************");
        //Verificamos si el involucrado ya tiene un aviso de detencion by Dorian
        if (avisoDao.involucradoTieneSolicitudDefensor(input.getInvolucradoDTO().getElementoId())) 
        	flagDetencion = true;
        System.out.print("*************** DECLARA DETENCION ***************");
        Detencion detencion = new Detencion();
        System.out.print("*************** FECHA INICIO DETENCION ***************"+input.getFechaInicioDetencion());
        detencion.setFechaInicioDetencion(input.getFechaInicioDetencion());
        System.out.print("*************** FECHA FIN DETENCION ***************"+input.getFechaFinDetencion());
        detencion.setFechaFinDetencion(input.getFechaFinDetencion());
        System.out.print("*************** FECHA RECEPCION DETENCION ***************"+input.getFechaRecepcionDetencion());
        detencion.setFechaRecepcionDetencion(input.getFechaRecepcionDetencion());
        System.out.print("*************** NUEVO INVOLUCRADO ***************");
        Involucrado inv = involucradoDAO.read(input.getInvolucradoDTO().getElementoId());
        System.out.print("Involucrado ID Leidoo :: " + input.getInvolucradoDTO().getElementoId());
        input.setInvolucradoDTO(InvolucradoTransformer.transformarInvolucrado(inv));
        detencion.setInvolucrado(inv);
        System.out.print("*************** NUEVO AVIDO DE DETENCION ***************");
	        AvisoDetencion aviso = new AvisoDetencion();
        System.out.print("*************** ENTRANDO VALIDACION ID DETNCION ***************");
	        if (input.getDetencionId()!=null) {
                System.out.print("*************** DENTRO DE LA VALIDACION ***************");
	        	aviso.setDetencion(new Detencion(input.getDetencionId()));
	        }
        System.out.print("*************** NOMBRE DEL DOUMENTO ***************");
	        aviso.setNombreDocumento("Aviso detencion de"
	                + input.getInvolucradoDTO().getNombreCompleto());
        System.out.print("*************** NOMBRE COMPLETO ***************");
	        aviso.setDetenido(input.getInvolucradoDTO().getNombreCompleto());
        System.out.print("***************FECHA DE CREACION ***************");
	        aviso.setFechaCreacion(new Date());
	        // TODO VAP definir forma y tipo de documento
	        aviso.setForma(new Forma(Formas.AUDIENCIA.getValorId()));
        System.out.print("*************** TIPO DE DOCUMENTO ***************");
	        aviso.setTipoDocumento(new Valor(TipoDocumento.ACUSE
	                .getValorId()));
        System.out.print("*************** FOLIO SOLICITUD ***************"+generarFolioSolicitudService
                .generarFolioNotificacion());
	        aviso.setFolioNotificacion(generarFolioSolicitudService
	                .generarFolioNotificacion());
	        ConfInstitucion confI = confInsDao.consultarInsitucionActual();
        System.out.print("*************** AVISO INSTITUCION ***************");
	        aviso.setConfInstitucion(confI);
        System.out.print("*************** CONSECUTIVO NOTIFICACION ***************");
	        aviso.setConsecutivoNotificacion("1");
        System.out.print("*************** ESTATUS ***************");
	        aviso.setEstatus(new Valor(EstatusNotificacion.EN_PROCESO.getValorId()));
        System.out.print("*************** CREANDO LA BANDERA D AVISO  ***************");
	        if(!flagDetencion)
	        	this.avisoDao.create(aviso);
        detencion.setAvisoDetencion(aviso);
        System.out.print("*************** nuevo avisoDto  ***************");
        AvisoDetencionDTO avisoDto = new AvisoDetencionDTO();
        System.out.print("*************** setteando el folio de la solicitud  ***************");
        avisoDto.setFolioNotificacion(aviso.getFolioNotificacion());
        System.out.print("*************** GENERANDO EL CASO  ***************");
        CasoDTO caso = (input.getInvolucradoDTO().getExpedienteDTO() != null && input.getInvolucradoDTO().getExpedienteDTO().getCasoDTO() != null ?
        		input.getInvolucradoDTO().getExpedienteDTO().getCasoDTO(): null );
        System.out.print("*************** VALIDACIN DEL CASO PARA TRASMITIR HACIA DEFENSORIA ***************");
        if(caso != null && caso.getNumeroGeneralCaso() != null)
        	avisoDto.setNumeroCasoAsociado(caso.getNumeroGeneralCaso());
        this.transmitir(input, avisoDto, caso,idAgencia,claveAgencia,idFuncionarioSolicitante);
        System.out.print("*************** VALIDANDO LA DTENCION  ***************");
        if (input.getDetencionId()==null) {
        	this.detencionDao.create(detencion);
        }
        System.out.print("guardado local [OK]");
        System.out.print("transmision [OK]");
    }


    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
    private void transmitir(DetencionDTO input, AvisoDetencionDTO avisoDto,
            CasoDTO caso,Long idAgencia, String claveAgencia,Long idFuncionarioSolicitante) throws NSJPNegocioException {
        System.out.print("Inicia transimision...");
        clienteWs.enviarAvisoDetencion(input, avisoDto, caso,idAgencia,claveAgencia, idFuncionarioSolicitante);
        System.out.print("transmision [OK]");
    }
}
