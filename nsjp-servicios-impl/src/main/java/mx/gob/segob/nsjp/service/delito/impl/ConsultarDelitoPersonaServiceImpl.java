/**
* Nombre del Programa : ConsultarDelitoPersonaServiceImpl.java
* Autor                            : adrian
* Compania                    : Ultrasist
* Proyecto                      : NSJP                    Fecha: 08/07/2011
* Marca de cambio        : N/A
* Descripcion General    : Describir el objetivo de la clase de manera breve
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
package mx.gob.segob.nsjp.service.delito.impl;

import java.util.ArrayList;
import java.util.List;

import mx.gob.segob.nsjp.comun.enums.excepciones.CodigoError;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dao.organizacion.OrganizacionDAO;
import mx.gob.segob.nsjp.dao.persona.DelitoPersonaDAO;
import mx.gob.segob.nsjp.dao.relacion.RelacionDAO;
import mx.gob.segob.nsjp.dto.audiencia.SituacionImputadoDTO;
import mx.gob.segob.nsjp.dto.expediente.DelitoDTO;
import mx.gob.segob.nsjp.dto.expediente.DelitoPersonaDTO;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.involucrado.InvolucradoDTO;
import mx.gob.segob.nsjp.model.DelitoPersona;
import mx.gob.segob.nsjp.model.SituacionImputado;
import mx.gob.segob.nsjp.service.delito.ConsultarDelitoPersonaService;
import mx.gob.segob.nsjp.service.delito.ConsultarDelitoService;
import mx.gob.segob.nsjp.service.delito.impl.transform.DelitoPersonaTransfromer;
import mx.gob.segob.nsjp.service.utilerias.enable.ConstructorCamposFaltantes;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Describir el objetivo de la clase con punto al final.
 * @version 1.0
 * @author adrian
 *
 */
@Service
@Transactional
public class ConsultarDelitoPersonaServiceImpl implements
		ConsultarDelitoPersonaService {
	public final static Logger logger =
		Logger.getLogger(ConsultarDelitoPersonaServiceImpl.class);

	@Autowired
	private DelitoPersonaDAO delPerDao;

	@Autowired
	private ConsultarDelitoService consultarDelitoService;


	 @Autowired
	 private RelacionDAO relacionDAO;

	 @Autowired
	 private OrganizacionDAO organizacionDAO;

	/* (non-Javadoc)
	 * @see mx.gob.segob.nsjp.service.delito.ConsultarDelitoPersonaService#consultarDelitosVictimaPorImputado(java.lang.Long, java.lang.Long)
	 */
	@Override
	public List<DelitoPersonaDTO> consultarDelitosVictimaPorImputado(
			Long idInvolucrado, Long idExpediente) throws NSJPNegocioException {

		if (logger.isDebugEnabled())
			logger.debug("/**** SERVICIO PARA CONSULTAR DELITO PERSONA POR EXPEDIENTE Y PROBABLE RESPONSABLE ****/");

		/*Verificaci�n de par�metros*/
		if(idInvolucrado==null||idExpediente==null)
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);

		List<DelitoPersona> delitos = delPerDao.consultarDelitosPorImputadoResponsable(idInvolucrado, idExpediente);
		List<DelitoPersonaDTO> delitosDTOS = new ArrayList<DelitoPersonaDTO>();
		for (DelitoPersona dPer : delitos) {
			DelitoPersonaDTO delPerDTO = DelitoPersonaTransfromer.transformarDelitoPersonaDTO(dPer);

			if(dPer.getVictima() != null){
				if(delPerDTO.getVictima() != null){
					ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
							dPer.getVictima(), delPerDTO.getVictima());
				}else{
					InvolucradoDTO invDTO = new InvolucradoDTO();
					ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
							dPer.getVictima(), delPerDTO.getVictima());
					delPerDTO.setVictima(invDTO);
				}
			}
			delitosDTOS.add(delPerDTO);

		}
		return delitosDTOS;
	}

	@Override
	public List<DelitoPersonaDTO> consultarVictimaImputadoPorDelito(
			Long idDelito, Long idExpediente) throws NSJPNegocioException {
		if (logger.isDebugEnabled())
			logger.debug("/**** SERVICIO PARA CONSULTAR DELITO PERSONA POR EXPEDIENTE Y DELITO ****/");

		/*Verificaci�n de par�metros*/
		if(idExpediente==null)
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);

		List<DelitoPersona> delitos = delPerDao.consultarVictimaImputadoPorDelito(idDelito, idExpediente);
		List<DelitoPersonaDTO> delitosDTOS = new ArrayList<DelitoPersonaDTO>();
		for (DelitoPersona dPer : delitos) {
			DelitoPersonaDTO delPerDTO = DelitoPersonaTransfromer.transformarDelitoPersonaDTO(dPer);
			if(dPer.getVictima() != null){
				if(delPerDTO.getVictima() != null){
					ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
							dPer.getVictima(), delPerDTO.getVictima());
				}else{
					InvolucradoDTO invDTO = new InvolucradoDTO();
					ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
							dPer.getVictima(), delPerDTO.getVictima());
					delPerDTO.setVictima(invDTO);
				}
			}
			delitosDTOS.add(delPerDTO);
		}
		return delitosDTOS;
	}

	@Override
	public Boolean existeRelacionPersonaDelitoExpediente(
			Long idDelito, Long idExpediente) throws NSJPNegocioException {
		if (logger.isDebugEnabled())
			logger.debug("/**** SERVICIO PARA VALIDAR SI EXISTE UNA RELACION DEL DELITO CON UNA PERSONA (DELITOPERSONA) ****/");

		/*Verificaci�n de par�metros*/
		if(idExpediente==null)
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);

		List<DelitoPersona> delitos = delPerDao.consultarVictimaImputadoPorDelito(idDelito, idExpediente);
		return delitos.isEmpty()?false:true; //Si esta vacia no existe relaci�n, si no esta vacia existe relacion
	}

	@Override
	public List<DelitoPersonaDTO> consultarDelitosPersonaPorExpedienteIdsDelito(
			List<Long> idsDelitos, Long idExpediente) throws NSJPNegocioException {
		if (logger.isDebugEnabled())
			logger.debug("/**** SERVICIO PARA CONSULTAR DELITO PERSONA POR EXPEDIENTE Y LISTA DE IDS DE DELITOS ****/");

		/*Verificaci�n de par�metros*/
		if(idExpediente==null)
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);

		List<DelitoPersona> delitos = delPerDao.consultarDelitosPersonaPorExpedienteIdsDelito(idsDelitos, idExpediente);
		List<DelitoPersonaDTO> delitosDTOS = new ArrayList<DelitoPersonaDTO>();
		for (DelitoPersona dPer : delitos) {
			delitosDTOS.add(DelitoPersonaTransfromer.transformarDelitoPersonaDTO(dPer));
		}
		return delitosDTOS;
	}

	/*
	 * (non-Javadoc)
	 * @see mx.gob.segob.nsjp.service.delito.ConsultarDelitoPersonaService#consultarDelitosVictimaPorImputado(java.lang.Long)
	 */
	@Override
	public List<DelitoPersonaDTO> consultarDelitosVictimaPorImputado(
			Long idInvolucrado) {
		List<DelitoPersona> delitosPer = delPerDao.consultarDelitosPorImputadoResponsable(idInvolucrado);
		List<DelitoPersonaDTO> resultado = new ArrayList<DelitoPersonaDTO>();
		for(DelitoPersona delito:delitosPer){
			resultado.add(DelitoPersonaTransfromer.transformarDelitoPersonaDTO(delito));
		}

		return resultado;
	}

	/**
	 * Servicio que permite consultar la relacion de probables responsables
	 * @author ricardog
	 */
	public List<DelitoPersonaDTO> consultarVictimaImputadoPorExpediente(Long idExpediente) throws NSJPNegocioException {
		if (logger.isDebugEnabled())
			logger.debug("/**** SERVICIO PARA CONSULTAR DELITOS PERSONA POR EXPEDIENTE ****/");



		/*Verificaci�n de par�metros*/
		if(idExpediente==null)
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);

		ExpedienteDTO loExpedienteDTO = new ExpedienteDTO();
		loExpedienteDTO.setExpedienteId(idExpediente);
		List<DelitoDTO> delitos = consultarDelitoService.consultarDelitoExpediente(loExpedienteDTO);

		List<DelitoPersonaDTO> delitosDTOS = new ArrayList<DelitoPersonaDTO>();
		for (DelitoDTO delitoDTO : delitos) {
			List<DelitoPersona> delitosPersona = delPerDao.consultarVictimaImputadoPorDelito(delitoDTO.getDelitoId(), idExpediente);
			for (DelitoPersona dPer : delitosPersona) {

				DelitoPersonaDTO delPerDTO = DelitoPersonaTransfromer.transformarDelitoPersonaDTO(dPer);
				if(dPer.getVictima() != null){
					if(delPerDTO.getVictima() != null){
						ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
								dPer.getVictima(), delPerDTO.getVictima());
					}else{
						InvolucradoDTO invDTO = new InvolucradoDTO();
						ConstructorCamposFaltantes.crearNombresDemograficosParaDTO(relacionDAO, organizacionDAO,
								dPer.getVictima(), delPerDTO.getVictima());
						delPerDTO.setVictima(invDTO);
					}
				}

				delitosDTOS.add(delPerDTO);
			}
		}
		return delitosDTOS;
	}


	public void desactivarDelitoPersona(Long delitoPersonaId)throws NSJPNegocioException {
		delPerDao.desactivarDelitoPersona(delitoPersonaId);
	}

	public Boolean eliminarDelitoPersona(Long delitoPersonaId)throws NSJPNegocioException {
		if(delitoPersonaId==null || delitoPersonaId < 0){
			throw new NSJPNegocioException(CodigoError.PARAMETROS_INSUFICIENTES);
		}
		DelitoPersona delitoPersona = delPerDao.read(delitoPersonaId);
		if(delitoPersona==null){
			throw new NSJPNegocioException(CodigoError.INFORMACION_PARAMETROS_ERRONEA);
		}
		delPerDao.delete(delitoPersona);
		return (true);
	}
	
	
	public SituacionImputadoDTO consultarSituacionImputadoPorId(Long idSituacion) throws NSJPNegocioException {
		
		SituacionImputadoDTO situacionImputadoDTO = new SituacionImputadoDTO();
		
		SituacionImputado situacionImputado = delPerDao.consultarSituacionImputadoPorId(idSituacion);
		
		logger.info("Situacion Imputado ::: " + situacionImputado);
		
		if(situacionImputado != null){
			situacionImputadoDTO.setSituacionImputadoId(situacionImputado.getSituacionImputadoId());
			situacionImputadoDTO.setDescripcion(situacionImputado.getDescripcion());
			situacionImputadoDTO.setPrioridad(situacionImputado.getPrioridad());
			
			logger.info(" SI descripcion ::: " + situacionImputado.getDescripcion() + " SI Prioridad ::: " + situacionImputado.getPrioridad());
		}
		
		return situacionImputadoDTO;
	}

}
