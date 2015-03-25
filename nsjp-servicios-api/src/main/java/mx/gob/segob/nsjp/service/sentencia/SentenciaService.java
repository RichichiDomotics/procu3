/**
 * 
 */
package mx.gob.segob.nsjp.service.sentencia;

import java.util.List;

import mx.gob.segob.nsjp.comun.enums.institucion.Instituciones;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dto.persona.NombreDemograficoDTO;
import mx.gob.segob.nsjp.dto.sentencia.SentenciaDTO;
import mx.gob.segob.nsjp.dto.sentencia.SentenciaWSDTO;

/**
 * @author AntonioBV
 *
 */
public interface SentenciaService {

	
	/**
	 * M&eacute;todo que consulta un NUS en base al CURP del Involucrado 
	 * @param nombreDemografico DTO
	 * @return
	 * @throws NSJPNegocioException
	 */
	List<SentenciaDTO> consultarNUS(NombreDemograficoDTO nombreDemograficoDTO)throws NSJPNegocioException;
	
	
	SentenciaDTO consultarSentenciaCompleta(SentenciaDTO sentenciaDTO)throws NSJPNegocioException;
	
	void crearSentencia(SentenciaWSDTO sentenciaWSDTO)throws NSJPNegocioException;
	
	boolean enviarSentencia(SentenciaDTO sentenciaDTO, Instituciones institucion) throws NSJPNegocioException;

	/**
	 * M&eacute;todo que crea o actualiza una sentencia. 
	 * @param sentenciaDTO sentencia a crear o actualizar.
	 * @return Sentencia con los datos persistidos.
	 * @throws NSJPNegocioException
	 */
	SentenciaDTO realizarAltasCambiosASentencia(SentenciaDTO sentenciaDTO) throws NSJPNegocioException;

	/**
	 * M&eacute;todo que crea o actualiza una sentencia. 
	 * @author Gustavo
	 * @param sentenciaDTO sentencia a crear o actualizar.
	 * @return Sentencia con los datos persistidos.
	 * @throws NSJPNegocioException
	 * */
	
	SentenciaDTO realizarAltaSentencia(SentenciaDTO sentenciaDTO) throws NSJPNegocioException;

}
