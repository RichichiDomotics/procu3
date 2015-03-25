/**
 * 
 */
package mx.gob.segob.nsjp.service.infra.impl;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.GregorianCalendar;
import java.util.List;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.namespace.QName;

import com.google.gson.Gson;
import mx.gob.segob.nsjp.comun.enums.excepciones.CodigoError;
import mx.gob.segob.nsjp.comun.enums.institucion.Instituciones;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dao.institucion.ConfInstitucionDAO;
import mx.gob.segob.nsjp.dto.caso.CasoDTO;
import mx.gob.segob.nsjp.dto.documento.AvisoDetencionDTO;
import mx.gob.segob.nsjp.dto.expediente.DelitoDTO;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.involucrado.DetencionDTO;
import mx.gob.segob.nsjp.dto.involucrado.InvolucradoDTO;
import mx.gob.segob.nsjp.dto.persona.NombreDemograficoDTO;
import mx.gob.segob.nsjp.dto.solicitud.SolicitudDefensorDTO;
import mx.gob.segob.nsjp.service.expediente.ConsultarCarpetaDeInvestigacionService;
import mx.gob.segob.nsjp.service.infra.DefensoriaClienteService;
import mx.gob.segob.nsjp.service.infra.impl.transform.WsTransformer;
import mx.gob.segob.nsjp.service.infra.impl.transform.enviarcarpetainvestigacion.ExpedienteWSDTOTransformer;
import mx.gob.segob.nsjp.ws.cliente.avisodetencion.AvisoDetencionWSDTO;
import mx.gob.segob.nsjp.ws.cliente.avisodetencion.DetencionWSDTO;
import mx.gob.segob.nsjp.ws.cliente.avisodetencion.RegistrarAvisoDetencionDeAreaExternaExporter;
import mx.gob.segob.nsjp.ws.cliente.avisodetencion.RegistrarAvisoDetencionDeAreaExternaExporterImplService;
import mx.gob.segob.nsjp.ws.cliente.enviarcarpetainvestigacion.EnviarCarpetaDeInvestigacionExporter;
import mx.gob.segob.nsjp.ws.cliente.enviarcarpetainvestigacion.EnviarCarpetaDeInvestigacionExporterImplService;
import mx.gob.segob.nsjp.ws.cliente.enviarcarpetainvestigacion.ExpedienteWSDTO;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.AudienciaWSDTO;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.DelitoWSDTO;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.NSJPNegocioException_Exception;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.RegistrarSolicitudDefensorAreaExternaExporter;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.RegistrarSolicitudDefensorAreaExternaExporterImplService;
import mx.gob.segob.nsjp.ws.cliente.solicituddefensor.SolicitudDefensorWSDTO;

import org.apache.log4j.Logger;
import org.omg.IOP.ExceptionDetailMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Cliente de defensoria
 * 
 * @author vaguirre
 * 
 */
@Service
@Transactional(propagation=Propagation.NOT_SUPPORTED)
public class DefensoriaClienteServiceImpl implements DefensoriaClienteService {
    /**
     * Logger.
     */
    private final static Logger logger = Logger
            .getLogger(DefensoriaClienteServiceImpl.class);

    @Autowired
    private ConfInstitucionDAO confInsDao;

	@Autowired
	ConsultarCarpetaDeInvestigacionService consultarCarpetaDeInvestigacionService;

    /*
     * (non-Javadoc)
     * 
     * @see mx.gob.segob.nsjp.service.infra.DefensoriaClienteService#
     * enviarSolicitudDefensor
     * (mx.gob.segob.nsjp.dto.solicitud.SolicitudDefensorDTO)
     */
    @Override
    public SolicitudDefensorDTO enviarSolicitudDefensor(
            SolicitudDefensorDTO input) throws NSJPNegocioException {
        URL ep;
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("input :: " + input);
            }
            ep = new URL(
                    confInsDao.read(Instituciones.DEF.getValorId())
                            .getUrlInst()
                            + "/RegistrarSolicitudDefensorAreaExternaExporterImplService?wsdl");

            final QName SERVICE_NAME = new QName(
                    "http://impl.ws.service.nsjp.segob.gob.mx/",
                    "RegistrarSolicitudDefensorAreaExternaExporterImplService");
            RegistrarSolicitudDefensorAreaExternaExporterImplService ss = new RegistrarSolicitudDefensorAreaExternaExporterImplService(
                    ep, SERVICE_NAME);
            RegistrarSolicitudDefensorAreaExternaExporter port = ss
                    .getRegistrarSolicitudDefensorAreaExternaExporterImplPort();
            logger.debug("Port obtenido....");
            SolicitudDefensorWSDTO toSend = new SolicitudDefensorWSDTO();

            AudienciaWSDTO aud = new AudienciaWSDTO();

            aud.setFechaHoraAudiencia(WsTransformer.transformFecha(input.getAudiencia().getFechaEvento()));
            aud.setDomicilioSala(input.getAudiencia().getSala().getDomicilioSala());
            aud.setUbicacionSala(input.getAudiencia().getSala().getUbicacionSala());
            aud.setNombreSala(input.getAudiencia().getSala().getNombreSala());
            aud.setTipoAudienciaId(input.getAudiencia().getTipoAudiencia().getIdCampo());
            aud.setFechaAsignacionSala(WsTransformer.transformFecha(input.getAudiencia().getFechaAsignacionSala()));
            aud.setDuracionEstimada(input.getAudiencia().getDuracionEstimada());
            aud.setEstatusAudienciaId(input.getAudiencia().getEstatusAudiencia().getIdCampo());
           
            toSend.setAudiencia(aud);
            toSend.setEsDetenido(input.isEsDetenido()); 
            toSend.setFolioSolicitud(input.getFolioSolicitud());
            toSend.setFolioElemento(input.getInvolucradoDTO().getFolioElemento());
            toSend.setNombreImputado(input.getNombreDetenido());
            toSend.setApellidoPaternoImputado(input.getApellidPaternoDetenido());
            toSend.setApellidoMaternoImputado(input.getApellidoMaternoDetenido());
            toSend.setNumeroCasoAsociado(input.getNumeroCasoAsociado());
            toSend.setFolioElemento(input.getFolioElementoDetenido());
            DelitoWSDTO delito = null;

            List<DelitoDTO> del = input.getDelitos();
            for (DelitoDTO delitoDTO : del) {
                delito = new DelitoWSDTO();
                delito.setEsPrincipal(delitoDTO.getEsPrincipal());
                delito.setEsProbable(delitoDTO.getEsProbable());
                delito.setIdCatDelito(delitoDTO.getCatDelitoDTO().getCatDelitoId());
                toSend.getDelitos().add(delito);
            }

            logger.debug("Invocando registrarSolicitudDefensor...");

            SolicitudDefensorWSDTO resp = port
                    .registrarSolicitudDefensor(toSend);

            SolicitudDefensorDTO response = new SolicitudDefensorDTO();

            logger.debug("Se registro en defensoria la solicitud con ID :: "
                    + resp.getSolicitudId());
            response.setDocumentoId(resp.getSolicitudId());

            return response;
        } catch (MalformedURLException e) {
            logger.error(e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        } catch (NSJPNegocioException_Exception e) {
            logger.error(e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        }
    }

    @Override
    public AvisoDetencionDTO enviarAvisoDetencion(DetencionDTO input, AvisoDetencionDTO aviso,
            CasoDTO noCaso,Long idAgencia, String claveAgencia,Long idFuncionarioSolicitante) throws NSJPNegocioException {
        URL ep;
        if (logger.isDebugEnabled()) {
            System.out.print("input :: " + input);
        }
        try {
            ep = new URL(
                    confInsDao.read(Instituciones.DEF.getValorId())
                    .getUrlInst()
                    +  "/RegistrarAvisoDetencionDeAreaExternaExporterImplService?wsdl");

            final QName SERVICE_NAME = new QName(
                    "http://impl.ws.service.nsjp.segob.gob.mx/",
                    "RegistrarAvisoDetencionDeAreaExternaExporterImplService");

            RegistrarAvisoDetencionDeAreaExternaExporterImplService ss = new RegistrarAvisoDetencionDeAreaExternaExporterImplService(
                    ep, SERVICE_NAME);
            System.out.print("Creando cliente para " + ep);
            System.out.print("getFechaRecepcionDetencion :: " + input.getFechaRecepcionDetencion());
            RegistrarAvisoDetencionDeAreaExternaExporter port = ss
                    .getRegistrarAvisoDetencionDeAreaExternaExporterImplPort();
            System.out.print("*************** OBJETO AVISODETENCIONWSDTO  ***************");
            AvisoDetencionWSDTO toSend = new AvisoDetencionWSDTO();
            System.out.print("*************** VALIDANDO NUEMRO DE CASO  ***************"+noCaso.getNumeroGeneralCaso());
            if(noCaso != null && noCaso.getNumeroGeneralCaso() != null)
                System.out.print("*************** NUEMRO ASOCIADO DEL CASO  ***************");
            	toSend.setNumeroCasoAsociado(noCaso.getNumeroGeneralCaso());
            System.out.print("*************** INSTITUCION PERTENECIENTE  ***************"+this.confInsDao.consultarInsitucionActual().getConfInstitucionId());
            toSend.setConfInstitucionId(this.confInsDao.consultarInsitucionActual().getConfInstitucionId());
            System.out.print("*************** OBTENIENDO INVOLUCRADO ***************"+input.getInvolucradoDTO());
            InvolucradoDTO imputado = input.getInvolucradoDTO();
            System.out.print("*************** DECLARANDO OBJETO DETENCIONWSDTO  ***************");
            DetencionWSDTO detencion = new DetencionWSDTO();
            mx.gob.segob.nsjp.ws.cliente.avisodetencion.DelitoWSDTO del = null;
            System.out.print("*************** VALIDNDO DELITOS COMETIDOS  ***************");
            if (imputado.getDelitosCometidos()!=null){
                System.out.print("*************** DENTRO DE LA VALIDACIONDE DELITOS COMETIDOS  ***************");
                System.out.print("*************** FOR PARA BARRER DELITOS COMETIDOS  ***************");
            for(DelitoDTO delito : imputado.getDelitosCometidos()){
                System.out.print("*************** DENTRO DEL FOR PARA BARRER DELITOS COMETIDOS  ***************");
            	del = new mx.gob.segob.nsjp.ws.cliente.avisodetencion.DelitoWSDTO();
        		del.setEsPrincipal(delito.getEsPrincipal());
        		del.setEsProbable(delito.getEsProbable());
        		del.setNombreDelito(delito.getCatDelitoDTO().getNombre());
        		del.setIdCatDelito(delito.getCatDelitoDTO().getCatDelitoId());
            	toSend.getDelitos().add(del);
            }
                System.out.print("*************** SALIENDO DEL FOR PARA BARRER DELITOS COMETIDOS  ***************");
            }
            System.out.print("*************** TERMINA VALIDACION DE DELITOS COMETIDOS  ***************");
            GregorianCalendar c = (GregorianCalendar) GregorianCalendar.getInstance();
            System.out.print("*************** OBTENIENDO FOLIO ELEMENTO ***************"+imputado.getFolioElemento());
            detencion.setFolioElemento(imputado.getFolioElemento());
            System.out.print("*************** OBTENIENDO NOMBE COMPLETO ***************"+imputado.getNombreCompleto());
            detencion.setDetenido(imputado.getNombreCompleto());
            detencion.setConfInstitucionId(confInsDao.consultarInsitucionActual().getConfInstitucionId());
            System.out.print("*************** NOMBRE DEMOGRAFICO ***************"+imputado.getNombresDemograficoDTO().get(0));
            NombreDemograficoDTO ndDTO = imputado.getNombresDemograficoDTO().get(0);
            System.out.print("*************** SET NOMBRE DETENIDO  ***************");
            detencion.setNombreDetenido(ndDTO.getNombre());
            detencion.setApellidoPaternoDetenido(ndDTO.getApellidoPaterno());
            detencion.setApellidoMaternoDetenido(ndDTO.getApellidoMaterno());
            System.out.print("*************** OBTENIENDO LUGAR DE DETENCION  ***************"+input.getLugarDetencionDTO());
            if (input.getLugarDetencionDTO()!=null) {
                System.out.print("*************** SET LUGAR DE DETNCION  ***************");
            	detencion.setLugarDetencion(input.getLugarDetencionDTO().getDescripcion());
            }
            System.out.print("*************** OBTENIENDO LUGAR DE DETENCION PROVISIONAL  ***************"+input.getLugarDetencionProvicional());
            detencion.setLugarDetencionProvisional(input.getLugarDetencionProvicional());
            System.out.print("*************** MOTIVO DE DETENCION  ***************"+input.getMotivoDetencion());
            detencion.setMotivoDetencion(input.getMotivoDetencion());
            System.out.print("*************** OBSERVCIONES  ***************"+input.getObservaciones());
            detencion.setObservaciones(input.getObservaciones());
            try{
            	if(input.getFechaFinDetencion() != null){
	            	c.setTime(input.getFechaFinDetencion());
	            detencion.setFechaFinDetencion(DatatypeFactory.newInstance().newXMLGregorianCalendar(c));
            	}
            	if(input.getFechaInicioDetencion() != null){
	            	c.setTime(input.getFechaInicioDetencion());
	            detencion.setFechaInicioDetencion(DatatypeFactory.newInstance().newXMLGregorianCalendar(c));
            	}
            	if(input.getFechaRecepcionDetencion() != null){
	            	c.setTime(input.getFechaRecepcionDetencion());
	            detencion.setFechaRecepcionDetecion(DatatypeFactory.newInstance().newXMLGregorianCalendar(c));
            	}
            }catch(DatatypeConfigurationException e){
                System.out.print("Error de Transformacion de fechas"+e.getMessage());
            	throw new NSJPNegocioException(CodigoError.ERROR_TRANSORMACION_FECHAS);
            }

            System.out.print("***************SET DETENCION  ***************");
            toSend.setDetencion(detencion);
            toSend.setFolioNotificacion(aviso.getFolioNotificacion());

            System.out.print("Invocando registrarAvisoDetencion...");
            AvisoDetencionWSDTO resp = port.registrarAvisoDetencion(toSend,idAgencia,claveAgencia,idFuncionarioSolicitante);
            System.out.print("Exitoso registrarAvisoDetencion...");
            AvisoDetencionDTO response = new AvisoDetencionDTO();
            System.out.print("resp.getAvisoDetencionId()"+resp.getAvisoDetencionId());
            response.setDocumentoId(resp.getAvisoDetencionId());

            return response;

        } catch (MalformedURLException e) {
            System.out.print("Primer Error"+e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        } catch (mx.gob.segob.nsjp.ws.cliente.avisodetencion.NSJPNegocioException_Exception e) {
            System.out.print("Segundo Error"+e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        }
    }

    @Override
    public ExpedienteDTO enviarCarpetaDeInvestigacion(
    		String numeroGeneralCaso, String folioSolicitud
    		) throws NSJPNegocioException {
        URL ep;
        if (logger.isDebugEnabled()) {
            logger.debug("enviarCarpetaDeInvestigacion numeroGeneralCaso = " + numeroGeneralCaso);
            logger.debug("enviarCarpetaDeInvestigacion folioSolicitud = " + folioSolicitud);
        }
        try {
            System.out.print(confInsDao.read(Instituciones.DEF.getValorId()).getUrlInst());
            ep = new URL(confInsDao.read(Instituciones.DEF.getValorId()).getUrlInst()
//        	ep = new URL("http://192.168.130.51:8080/nsjp-web"
                    + "/EnviarCarpetaDeInvestigacionExporterImplService?wsdl");
            logger.debug("Enviando carpeta a través de :: " + ep);
            final QName SERVICE_NAME = new QName(
                    "http://impl.ws.service.nsjp.segob.gob.mx/",
                    "EnviarCarpetaDeInvestigacionExporterImplService");
            EnviarCarpetaDeInvestigacionExporterImplService ss =
                    new EnviarCarpetaDeInvestigacionExporterImplService(ep, SERVICE_NAME);
            EnviarCarpetaDeInvestigacionExporter clienteEnviarCarpetaDeInvestigacion =
                    ss.getEnviarCarpetaDeInvestigacionExporterImplPort();
            // Hasta aqui finaliza la configuracion para acceder al web service
           
            //Se hace la consulta de la carpeta de investigacion de acuerdo a numeroGeneralCaso
            ExpedienteDTO expedienteDTO = consultarCarpetaDeInvestigacionService.consultarCarpetaDeInvestigacion(numeroGeneralCaso);
            System.out.print("*****************Expediente completo***********************");
            System.out.print(String.valueOf(expedienteDTO));
            if(expedienteDTO== null || expedienteDTO.getExpedienteId()== null || expedienteDTO.getInvolucradosDTO()== null ||
            		expedienteDTO.getInvolucradosDTO().isEmpty())
            	throw new NSJPNegocioException(CodigoError.INFORMACION_PARAMETROS_ERRONEA);
            
            // Aqui inicia el proceso de transformar los dto en wsDto
            try {
                ExpedienteWSDTO expedienteTransformado = ExpedienteWSDTOTransformer.transformarWSDTO(expedienteDTO);
            }
            catch (Exception e){
                System.out.print("Error al transformar el expediente: "+e.getMessage()+" Expediente: "+expedienteDTO);
            }
            ExpedienteWSDTO expedienteTransformado = ExpedienteWSDTOTransformer.transformarWSDTO(expedienteDTO);

            if(expedienteTransformado.getInvolucradosDTO()!= null)
            	logger.info("*************** Involucrado: " +expedienteTransformado.getInvolucradosDTO().size());
            logger.debug("************ ClienteEnviarCarpetaDeInvestigacion = " + clienteEnviarCarpetaDeInvestigacion);
            logger.info("*************** ANTES DE ENVIAR ***************");
//            ExpedientePrint.imprimirDatosExpediente(expedienteTransformado);
            //Gson gson = new Gson();
            //System.out.print(String.valueOf(expedienteDTO));

            System.out.print(String.valueOf(expedienteDTO));
            try {
                clienteEnviarCarpetaDeInvestigacion.enviarCarpetaDeInvestigacion(expedienteTransformado, numeroGeneralCaso, folioSolicitud);
            }catch (Exception e){
                System.out.print("Error del web service: "+String.valueOf(e));
            }
                Long id = clienteEnviarCarpetaDeInvestigacion.enviarCarpetaDeInvestigacion(expedienteTransformado, numeroGeneralCaso, folioSolicitud);
                if (logger.isDebugEnabled()) {
                    logger.debug("----------------------------------------id = " + id);
                }
                logger.info("Fin - enviarCarpetaDeInvestigacion(...) [OK]");
                return new ExpedienteDTO(id);

        } catch (mx.gob.segob.nsjp.ws.cliente.enviarcarpetainvestigacion.NSJPNegocioException_Exception e) {
            logger.error(e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        } catch (MalformedURLException e) {
            logger.error(e.getMessage());
            throw new NSJPNegocioException(CodigoError.ERROR_COMUNICACION, e);
        }
    }
}
