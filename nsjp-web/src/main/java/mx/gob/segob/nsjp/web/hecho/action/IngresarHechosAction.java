/**
 * Nombre del Programa 		: IngresarHechosAction.java
 * Autor                     : ArmandoCT
 * Compania                  : Ultrasist
 * Proyecto                  : NSJP                    Fecha: 14/junio/2011
 * Marca de cambio        	: N/A
 * Descripcion General    	: Clase Action para ingresar objetos
 * Programa Dependiente  	: N/A
 * Programa Subsecuente 		: N/A
 * Cond. de ejecucion        : N/A
 * Dias de ejecucion         : N/A                             Horario: N/A
 *                              MODIFICACIONES
 *------------------------------------------------------------------------------
 * Autor                     : N/A
 * Compania              	: N/A
 * Proyecto                 	: N/A                                 Fecha: N/A
 * Modificacion           	: N/A
 *------------------------------------------------------------------------------
 */
package mx.gob.segob.nsjp.web.hecho.action;

import mx.gob.segob.nsjp.comun.enums.calidad.Calidades;
import mx.gob.segob.nsjp.comun.enums.catalogo.Catalogos;
import mx.gob.segob.nsjp.comun.enums.expediente.OrigenExpediente;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.comun.util.DateUtils;
import mx.gob.segob.nsjp.delegate.expediente.ExpedienteDelegate;
import mx.gob.segob.nsjp.delegate.hecho.HechoDelegate;
import mx.gob.segob.nsjp.dto.catalogo.CatalogoDTO;
import mx.gob.segob.nsjp.dto.catalogo.ValorDTO;
import mx.gob.segob.nsjp.dto.domicilio.*;
import mx.gob.segob.nsjp.dto.elemento.CalidadDTO;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.hecho.HechoDTO;
import mx.gob.segob.nsjp.dto.hecho.TiempoDTO;
import mx.gob.segob.nsjp.dto.usuario.UsuarioDTO;
import mx.gob.segob.nsjp.web.base.action.GenericAction;
import mx.gob.segob.nsjp.web.hecho.form.HechoForm;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Clase Action para ingresar hechos.
 * 
 * @version 1.0
 * @author ArmandoCT
 * 
 */
public class IngresarHechosAction extends GenericAction {

	/* Log de clase */
	private static final Logger log = Logger
			.getLogger(IngresarHechosAction.class);

	@Autowired
	private HechoDelegate hechoDelegate;
	
	@Autowired
	private ExpedienteDelegate expedienteDelegate;

	/**
	 * Metodo utilizado para guardar un hecho
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return null, debido a la comunicacion Ajax
	 * @throws IOException
	 *             En caso de obtener una exception
	 */
	public ActionForward ingresarHecho(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		try {

			log.info("ejecutando Action guardar hecho");
			HechoForm forma = (HechoForm) form;
			
			log.info("FORMA HECHO:::::::::::::::::::::::");
			
			//Revisamos que el id del hecho no sea nulo
			if(StringUtils.isBlank(forma.getIdHecho()))
			{
				forma.setGcDescripcionHecho("0");
				log.info("Id Hecho --->  ES:null");
			}
			
			log.info("Descripcion="+ forma.getGcDescripcionHecho());	
			
			
			//Revisamos que la descripcion del hecho no sea nula
			if(forma.getGcDescripcionHecho().equalsIgnoreCase("") ){
				forma.setGcDescripcionHecho("");
				log.info("Descripcion, ES:null");
			}
			
			//revisamos que los datos de domicilio no sea nula
			
			if(StringUtils.isBlank(forma.getPais())){
				forma.setPais("");
			}
			if(StringUtils.isBlank(forma.getCodigoPostal())){
				forma.setCodigoPostal("");
			}
			
			if(StringUtils.isBlank(forma.getEntidadFederativa()) || forma.getEntidadFederativa().equalsIgnoreCase("-1")){
				forma.setEntidadFederativa(null);
			}
			
			if(StringUtils.isBlank(forma.getCiudad()) || forma.getCiudad().equalsIgnoreCase("-1")){
				forma.setCiudad(null);
			}
			
			if(StringUtils.isBlank(forma.getDelegacionMunicipio()) || forma.getDelegacionMunicipio().equalsIgnoreCase("-1")){
				forma.setDelegacionMunicipio(null);
			}
			
			if(StringUtils.isBlank(forma.getAsentamientoColonia()) || forma.getAsentamientoColonia().equalsIgnoreCase("-1")){
				forma.setAsentamientoColonia(null);
			}
			
			if(StringUtils.isBlank(forma.getTipoAsentamiento()) || forma.getTipoAsentamiento().equalsIgnoreCase("-1")){
				forma.setTipoAsentamiento(null);
			}
			
			if(StringUtils.isBlank(forma.getTipoCalle()) || forma.getTipoCalle().equalsIgnoreCase("-1")){
				forma.setTipoCalle(null);
			}
			
			if(StringUtils.isBlank(forma.getCalle())){
				forma.setCalle("");
			}
			
			if(StringUtils.isBlank(forma.getNumExterior())){
				forma.setNumExterior("");
			}
			
			if(StringUtils.isBlank(forma.getNumInterior())){
				forma.setNumInterior("");
			}
			
			if(StringUtils.isBlank(forma.getReferencias())){
				forma.setReferencias("");
			}
			
			if(StringUtils.isBlank(forma.getEntreCalle())){
				forma.setEntreCalle("");
			}
			
			if(StringUtils.isBlank(forma.getYcalle())){
				forma.setYcalle("");
			}
			
			if(StringUtils.isBlank(forma.getAliasDomicilio())){
				forma.setAliasDomicilio("");
			}
			
			if(StringUtils.isBlank(forma.getEdificio())){
				forma.setEdificio("");
			}
			
			if(StringUtils.isBlank(forma.getLongitud())){
				forma.setLongitud("");
			}
			
			if(StringUtils.isBlank(forma.getLatitud())){
				forma.setLatitud("");
			}
			//FIN revisamos que los datos de domicilio no sea nula
					
			//encapsulamos la informacion del tiempo
			TiempoDTO tiempoDTO=new TiempoDTO();
			ValorDTO valorDTO=new ValorDTO();
			boolean conTiempo = false;
			//revisamos que los datos de tiempo no sea nula
			if(Integer.parseInt(forma.getTipoTiempoHecho())>0)
			{
				List<CatalogoDTO> listaCatalogo= catDelegate.recuperarCatalogo(Catalogos.TIPO_TIEMPO);
				//encapsulamos la informacion del tiempo
				if(Integer.parseInt(forma.getTipoTiempoHecho())==1 && !forma.getFecha().isEmpty())//especifico
				{					
					/*************************************************/
					forma.setHora(IngresarHechosAction.FormateaHora(forma.getHora()));					
					/**************************************************/
				
					valorDTO.setIdCampo(listaCatalogo.get(0).getClave());
					tiempoDTO.setFechaInicio(DateUtils.obtener(forma.getFecha(),forma.getHora()));
					tiempoDTO.setTipoRegistro(valorDTO);
					conTiempo=true;
				}
				else if(Integer.parseInt(forma.getTipoTiempoHecho())==2 && !forma.getFechaInicioLapso().isEmpty()
						&& !forma.getFechaFinLapso().isEmpty())//lapso
				{
					/*************************************************/
					//7:00PM ---checar que pasa con el 7:00AM && 12:00AM
					if( forma.getHoraFinLapso().substring(4, 5).equals("P") ||
						forma.getHoraFinLapso().substring(4, 5).equals("A") ||
						forma.getHoraFinLapso().substring(5, 6).equals("P") ||
						forma.getHoraFinLapso().substring(5, 6).equals("A") )						
					   	{
						String aux= forma.getHoraFinLapso().substring(forma.getHoraFinLapso().length()-2,forma.getHoraFinLapso().length());
						String inicioCad=forma.getHoraFinLapso().substring(0,forma.getHoraFinLapso().length()-2);
					
						forma.setHoraFinLapso(inicioCad+" "+aux);				
					}
					
					if( forma.getHoraInicioLapso().substring(4, 5).equals("P") ||
							forma.getHoraInicioLapso().substring(4, 5).equals("A") ||
							forma.getHoraInicioLapso().substring(5, 6).equals("P") ||
							forma.getHoraInicioLapso().substring(5, 6).equals("A") )						
						   	{
							String aux= forma.getHoraInicioLapso().substring(forma.getHoraInicioLapso().length()-2,forma.getHoraInicioLapso().length());
							String inicioCad=forma.getHoraInicioLapso().substring(0,forma.getHoraInicioLapso().length()-2);
						
							forma.setHoraInicioLapso(inicioCad+" "+aux);				
						}
					
					forma.setHoraInicioLapso(IngresarHechosAction.FormateaHora(forma.getHoraInicioLapso()));
					forma.setHoraFinLapso(IngresarHechosAction.FormateaHora(forma.getHoraFinLapso()));
					/**************************************************/

					valorDTO.setIdCampo(listaCatalogo.get(1).getClave());
					tiempoDTO.setFechaInicio(DateUtils.obtener(forma.getFechaInicioLapso(),forma.getHoraInicioLapso()));
					tiempoDTO.setFechaFin((DateUtils.obtener(forma.getFechaFinLapso(),forma.getHoraFinLapso())));
					tiempoDTO.setTipoRegistro(valorDTO);
					conTiempo=true;
				}
				else if(Integer.parseInt(forma.getTipoTiempoHecho())==3)//descripcion hecho
				{
					valorDTO.setIdCampo(listaCatalogo.get(2).getClave());
					tiempoDTO.setDescripcion(forma.getGsNarrativa());
					tiempoDTO.setTipoRegistro(valorDTO);
					conTiempo=true;
				}				
			}
					
			//encapsulamos la informacion del expediente
			//ExpedienteDTO expedienteDTO=(ExpedienteDTO)request.getSession().getAttribute(forma.getNumExpediente());//new ExpedienteDTO(Long.parseLong(forma.getNumExpediente()));
			log.info("num_exp_hecho:: "+forma.getNumExpediente());
			ExpedienteDTO expedienteDTO=super.getExpedienteTrabajo(request, forma.getNumExpediente());
			log.info("id_num_exp_hecho:: "+forma.getNumeroExpedienteId());
			log.info("num_exp_DTO:: "+ expedienteDTO);
			if(forma.getNumeroExpedienteId()!=null && !forma.getNumeroExpedienteId().equals("null") && !forma.getNumeroExpedienteId().equals(""))
			{
				expedienteDTO.setNumeroExpedienteId(Long.parseLong(forma.getNumeroExpedienteId()));
			}
			log.info("num_exp_id_hecho:: "+ expedienteDTO.getNumeroExpedienteId());
			
			//creamos el hecho a insertar
			HechoDTO hechoDTO=new HechoDTO();
			if(conTiempo){
				hechoDTO.setTiempo(tiempoDTO);
			}			
			hechoDTO.setExpediente(expedienteDTO);
			hechoDTO.setDescNarrativa(forma.getGcDescripcionHecho());
			UsuarioDTO usuarioDTO=new UsuarioDTO();
			usuarioDTO.setIdUsuario(Long.parseLong(forma.getIdUsuario()));
			hechoDTO.setUsuario(usuarioDTO);
			
			//Revisamos que la fecha de arribo no sea nula
			if(!forma.getFechaArribo().equalsIgnoreCase("") && !forma.getHoraArribo().equalsIgnoreCase("")){
				
				forma.setHoraArribo(IngresarHechosAction.FormateaHora(forma.getHoraArribo()));
				
				hechoDTO.setFechaDeArribo(DateUtils.obtener(forma.getFechaArribo(),forma.getHoraArribo()));
			}
			
			CalidadDTO calidadDTO=new CalidadDTO();
			calidadDTO.setCalidades(Calidades.LUGAR_HECHOS);
			//Encapsulamos la informacion del domicilio
			if(Long.parseLong(forma.getPais())==10)//Mexico
			{
				DomicilioDTO domicilioDTO=new DomicilioDTO();
				
				//domicilioDTO.setLatitud(forma.getLatitud());
				//domicilioDTO.setLongitud(forma.getLongitud());
				
				if (!(forma.getLatitudN()== null) && !forma.getLatitudN().equals("")) {
					/*se cambia la forma del las coordenadas de Grados a Decimales/*Enable IT ByYolo*/
//					String lat= forma.getLatitudN()+forma.getLatitudGrados()+"�"+forma.getLatitudMinutos()+"'"+forma.getLatitudSegundos()+"\"";
					String lat= forma.getLatitudN();
					log.info("lat_hechoDTO:: "+lat);
					domicilioDTO.setLatitud(lat);
				}
				if (!(forma.getLongitudE()== null) && !forma.getLongitudE().equals("")) {
					/*se cambia la forma del las coordenadas de Grados a Decimales/*Enable IT ByYolo*/
//					String longitud= forma.getLongitudE()+forma.getLongitudGrados()+"�"+forma.getLongitudMinutos()+"'"+forma.getLongitudSegundos()+"\"";
					String longitud= forma.getLongitudE();
					log.info("lon_hechoDTO:: "+longitud);
					domicilioDTO.setLongitud(longitud);
				}
				
				domicilioDTO.setEdificio(forma.getEdificio());
				domicilioDTO.setAlias(forma.getAliasDomicilio());
				domicilioDTO.setEntreCalle2(forma.getYcalle());
				domicilioDTO.setEntreCalle1(forma.getEntreCalle());
				domicilioDTO.setReferencias(forma.getReferencias());
				domicilioDTO.setNumeroInterior(forma.getNumInterior());
				domicilioDTO.setNumeroExterior(forma.getNumExterior());
				domicilioDTO.setCalle(forma.getCalle());
				if(forma.getTipoCalle()!=null)
				{
					domicilioDTO.setValorCalleId(new ValorDTO(Long.parseLong(forma.getTipoCalle())));
				}
				domicilioDTO.setCalidadDTO(calidadDTO);
				domicilioDTO.setExpedienteDTO(expedienteDTO);
				domicilioDTO.setFechaCreacionElemento(new Date());
				//delcaramos el nuevo asentamiento
				AsentamientoDTO asentamientoDTO=new AsentamientoDTO();
				if(forma.getAsentamientoColonia()!=null)
				{
					log.info("ID_COLONIA::: "+forma.getAsentamientoColonia());
					asentamientoDTO.setAsentamientoId(Long.parseLong(forma.getAsentamientoColonia()));
				}
				asentamientoDTO.setCodigoPostal(forma.getCodigoPostal());
				
				//Declaramos el tipo de asentamiento
				if(forma.getTipoAsentamiento()!=null)
				{
					log.info("ID_TIPO_ASENTAMIENTO::: "+forma.getTipoAsentamiento());
					TipoAsentamientoDTO tipoAsentamientoDTO = new TipoAsentamientoDTO(Long.parseLong(forma.getTipoAsentamiento()),"");
					asentamientoDTO.setTipoAsentamientoDTO(tipoAsentamientoDTO);
				}
				//Declaramos el municipio
				MunicipioDTO municipioDTO=new MunicipioDTO();
				if(forma.getDelegacionMunicipio()!=null)
				{
					municipioDTO.setMunicipioId(Long.parseLong(forma.getDelegacionMunicipio()));
				}
				asentamientoDTO.setMunicipioDTO(municipioDTO);

				//declaramos la Ciudad
				CiudadDTO ciudadDTO = new CiudadDTO();
				if(forma.getCiudad()!=null)
				{
					ciudadDTO.setCiudadId(Long.parseLong(forma.getCiudad()));
				}
				//declaramos la entidad federativa
				EntidadFederativaDTO entidadFederativaDTO=new EntidadFederativaDTO();
				if(forma.getEntidadFederativa()!=null)
				{
					entidadFederativaDTO.setEntidadFederativaId(Long.parseLong(forma.getEntidadFederativa()));
				}
				if(forma.getPais()!=null)
				{
					entidadFederativaDTO.setValorIdPais(new ValorDTO(Long.parseLong(forma.getPais())));
				}
				ciudadDTO.setEntidadFederativaDTO(entidadFederativaDTO);
				asentamientoDTO.setCiudadDTO(ciudadDTO);
				domicilioDTO.setCiudadDTO(ciudadDTO);
				domicilioDTO.setEntidadDTO(entidadFederativaDTO);
				domicilioDTO.setAsentamientoDTO(asentamientoDTO);
				domicilioDTO.setMunicipioDTO(municipioDTO);
								
				//seteamos el domicilio al Hecho
				hechoDTO.setLugar(domicilioDTO);
			}
			else//Otro pais
			{
				DomicilioExtranjeroDTO domExtranjreoDTO= new DomicilioExtranjeroDTO();
				
				domExtranjreoDTO.setLatitud(forma.getLatitud());
				domExtranjreoDTO.setLongitud(forma.getLongitud());
				domExtranjreoDTO.setEdificio(forma.getEdificio());
				domExtranjreoDTO.setAlias(forma.getAliasDomicilio());
				domExtranjreoDTO.setEntreCalle2(forma.getYcalle());
				domExtranjreoDTO.setEntreCalle1(forma.getEntreCalle());
				domExtranjreoDTO.setReferencias(forma.getReferencias());
				domExtranjreoDTO.setNumeroInterior(forma.getNumInterior());
				domExtranjreoDTO.setNumeroExterior(forma.getNumExterior());
				domExtranjreoDTO.setCalle(forma.getCalle());
				domExtranjreoDTO.setPais(forma.getPais());
				domExtranjreoDTO.setCodigoPostal(forma.getCodigoPostal());
				domExtranjreoDTO.setCiudad(forma.getCiudad());
				domExtranjreoDTO.setMunicipio(forma.getDelegacionMunicipio());
				domExtranjreoDTO.setAsentamientoExt(forma.getAsentamientoColonia());
				domExtranjreoDTO.setEstado(forma.getEntidadFederativa());
				domExtranjreoDTO.setCalidadDTO(calidadDTO);
				domExtranjreoDTO.setExpedienteDTO(expedienteDTO);
				domExtranjreoDTO.setFechaCreacionElemento(new Date());
				//private String tipoAsentamiento; SE VA EN DOMICILIO EXTRANJERO
				//private String tipoCalle; SE VA EN DOMICILIO EXTRANJERO
								
				//seteamos el domicilio extranjero al Hecho
				hechoDTO.setLugar(domExtranjreoDTO);
			}
			
			//cambiamos el estatus del Expediente
			if(Long.parseLong(forma.getOrigenExpediente())==0)
			{
				//Denuncia
				expedienteDelegate.actualizarTipoExpediente(expedienteDTO, OrigenExpediente.DENUNCIA);
			}
			else
			{
				if(Long.parseLong(forma.getOrigenExpediente())==1){
					//Querella
					expedienteDelegate.actualizarTipoExpediente(expedienteDTO, OrigenExpediente.QUERELLA);
				}else
					expedienteDelegate.actualizarTipoExpediente(expedienteDTO, OrigenExpediente.REPORTE);

			}
			log.info("$$$$$ Ingreso_Hecho - MODIFIQUE EL ORIGEN DEL EXPEDIENTE :::::: "+expedienteDTO.getNumeroExpedienteId());
			log.info("idLugar_hechoDTO:: "+request.getParameter("idLugar"));
			log.info("idTiempo_hechoDTO:: "+request.getParameter("idTiempo"));
			//hacemos la insercion del hecho
			if(Long.parseLong(forma.getIdHecho())==0)
			{
				//esta es una inserci�n de Hecho
				hechoDTO= hechoDelegate.ingresarHecho(hechoDTO);
			}
			else
			{
				//esta es una modificacion de un hecho
				hechoDTO.setHechoId(Long.parseLong(forma.getIdHecho()));
				if (request.getParameter("idLugar")!=null && !request.getParameter("idLugar").isEmpty()) {
					hechoDTO.getLugar().setElementoId(Long.parseLong(request.getParameter("idLugar")));
				} else {
					hechoDTO.getLugar().setElementoId(null);
				}
				
				if (request.getParameter("idTiempo")!=null && !request.getParameter("idTiempo").isEmpty()) {
					hechoDTO.getTiempo().setTiempoId(Long.parseLong(request.getParameter("idTiempo")));
				} else if (conTiempo){
					hechoDTO.getTiempo().setTiempoId(null);
				}
				
				//FIXME aqui abajo iria el llamado al servicio de actualizacion del Hecho
				hechoDTO=hechoDelegate.modificarHecho(hechoDTO);
			}
			
			if(hechoDTO!=null && hechoDTO.getHechoId()!=null)
			{
				converter.alias("hechoDTO", HechoDTO.class);
				String xml = converter.toXML(hechoDTO);
				log.info("hechoDTO:: "+xml);
				escribirRespuesta(response, xml);
			}
			else
			{
				hechoDTO.setHechoId(0L);
				converter.alias("hechoDTO", HechoDTO.class);
				String xml = converter.toXML(hechoDTO);
				escribirRespuesta(response, xml);
			}
			log.info("Termina ejecucion Action guardar hecho - FIN ");
		} catch (NSJPNegocioException e) {
			log.error(e.getMessage(), e);
			escribir(response, "", e);
		}
		return null;
	}
	
	
	/*************************************************/
	/*************************************************/
	
	public static String FormateaHora(String strhora){
		String horaFormateada = null;
		String complemento=null;
		int hora = 0;
	
		if(strhora.contains("PM")){
			
			
			if(strhora.length()==7 || strhora.length() == 6 ){
				complemento=strhora.substring(1,strhora.length());
				hora=Integer.parseInt(strhora.substring(0, 1));
			}
			if(strhora.length()==8){
				complemento=strhora.substring(2,strhora.length());
				hora=Integer.parseInt(strhora.substring(0, 2));
			}	
				
			hora+=12;
			
			if(hora==24){
				hora=12;
			}
			horaFormateada=hora+""+complemento;	

		}else if(strhora.contains("AM")){
		
				if(strhora.length()==7 || strhora.length()==6 ){
					complemento=strhora.substring(1,strhora.length());
					hora=Integer.parseInt(strhora.substring(0, 1));
				}
				if(strhora.length()==8){
					complemento=strhora.substring(2,strhora.length());
					hora=Integer.parseInt(strhora.substring(0, 2));
				}
				
				if (hora==12){
					 hora=00;					
				 }	
				
				 horaFormateada=hora+""+complemento;
		}
		else{//sino trae ni am ni pm 
			
			strhora=strhora.trim();//quito espacios en blanco 
			
				if(strhora.length()== 4){
					hora=Integer.parseInt(strhora.substring(0,1));
					complemento= strhora.substring(1,strhora.length());

					complemento +=" AM";
					horaFormateada=hora+""+complemento;
				}
				
				if(strhora.length()== 5  ){
					hora=Integer.parseInt(strhora.substring(0,2));
					complemento=strhora.substring(2,strhora.length());

					if(hora>0 && hora <=11 ){//es AM
						complemento+=" AM";
					}
					if(hora==0 || hora >=12 ){
						complemento+=" PM";
					}
					
					horaFormateada=hora+""+complemento;
				}
		}
		return horaFormateada;
	}

	
	
	/**
	 * Metodo para actualizar un hecho con base a su Id
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward modificarHecho(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		try {

			/**
			 * Por el momento solo se va a modificar la narrativa o descripcion
			 */

			log.info("EJECUTANDO ACTION MODIFICAR HECHO");
			HechoForm forma = (HechoForm) form;

			log.info("************VERIFICANDO PARAMETROS****************");
			log.info("HECHO ID:::::::::::::::::::::::" + forma.getIdHecho());
			log.info("HECHO DESCRIPCION::::::::::::::" + forma.getGcDescripcionHecho());
			log.info("HECHO EXPEDIENTE_ID::::::::::::" + forma.getExpedienteId());

			// Revisamos que el id del hecho no sea nulo
			Long hechoId = NumberUtils.toLong(forma.getIdHecho(), 0L);
			Long expedienteId = NumberUtils.toLong(forma.getExpedienteId(), 0L);
			
			HechoDTO hechoDTO = new HechoDTO();

			if (hechoId != null && hechoId > 0L && expedienteId != null && expedienteId > 0L) {
				
				ExpedienteDTO expedienteDto = new ExpedienteDTO();
				expedienteDto.setExpedienteId(expedienteId);
				
				hechoDTO.setHechoId(hechoId);
				hechoDTO.setExpediente(expedienteDto);
				
				
				if(forma.getGcDescripcionHecho() != null && !forma.getGcDescripcionHecho().trim().isEmpty()){
					hechoDTO.setDescNarrativa(forma.getGcDescripcionHecho());
				}
				
				hechoDTO = hechoDelegate.modificarHecho(hechoDTO);
			}

			if (hechoDTO != null && hechoDTO.getHechoId() != null) {
				converter.alias("hechoDTO", HechoDTO.class);
				String xml = converter.toXML(hechoDTO);
				log.info("hechoDTO:: " + xml);
				escribirRespuesta(response, xml);
			}

		} catch (NSJPNegocioException e) {
			log.error(e.getMessage(), e);
			escribir(response, "", e);
		}
		return null;
	}
	
	/**
	 * Metodo para consultar un hecho con base a su Id
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward consultarHecho(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		try {

			log.info("EJECUTANDO ACTION CONSULTAR HECHO");
			
			log.info("EJECUTANDO ACTION MODIFICAR HECHO");
			HechoForm forma = (HechoForm) form;
			UsuarioDTO usuario = super.getUsuarioFirmado(request);
			
			log.info("************VERIFICANDO PARAMETROS****************");
			log.info("HECHO EXPEDIENTE_ID::::::::::::" + forma.getExpedienteId());

			Long expedienteId = NumberUtils.toLong(forma.getExpedienteId(), 0L);
			
			HechoDTO hechoDTO = new HechoDTO();
			List<HechoDTO> listaHechos = null;

			if (expedienteId != null && expedienteId > 0L) {
				
				ExpedienteDTO expedienteDto = new ExpedienteDTO();
				expedienteDto.setExpedienteId(expedienteId);
				hechoDTO.setExpediente(expedienteDto);
				
				listaHechos = hechoDelegate.consultarHechos(hechoDTO);
			}

			if (listaHechos != null && listaHechos.size() > 0 && listaHechos.get(0) != null) {
				listaHechos.get(0).setUsuario(usuario);
				converter.alias("usuarioDTO", UsuarioDTO.class);
				converter.alias("hechoDTO", HechoDTO.class);
				String xml = converter.toXML(listaHechos.get(0));
				log.info("hechoDTO:: " + xml);
				escribirRespuesta(response, xml);
			}
		} catch (NSJPNegocioException e) {
			log.error(e.getMessage(), e);
			escribir(response, "", e);
		}
		return null;
	}
	
}
