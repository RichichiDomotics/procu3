package mx.gob.segob.nsjp.service.informepolicial;

import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.informepolicial.InformePolicialHomologadoDTO;
import mx.gob.segob.nsjp.dto.informepolicial.OperativoDTO;
import mx.gob.segob.nsjp.dto.usuario.UsuarioDTO;

import java.util.List;

public interface InformePolicialHomologadoService {	
	
	public Long ingresarDatosGenerales(InformePolicialHomologadoDTO iph, OperativoDTO operativo) 
	                                   throws NSJPNegocioException;		
	
	public InformePolicialHomologadoDTO ObtenerFolioIPH(ExpedienteDTO expedienteDTO) throws NSJPNegocioException;
	public InformePolicialHomologadoDTO consultarInformePorFolio(Long folio) throws NSJPNegocioException;
	
	/**
	 * Operaci�n que permite consultar todos los informes policiales homologados distinguiendo por el par�metro recibido
	 * @param conDetenido: 	True	(Consulta los informes que en sus involucrados tengan alg�n detenido)
	 * 						False	(Consulta los informes que en sus involucrados no exista ning�n detenido)
	 * 						Null 	(Consulta Todos los informes)
	 * @return
	 * @throws NSJPNegocioException
	 */
	public List<InformePolicialHomologadoDTO> consultarInformes(Boolean conDetenido, UsuarioDTO usuario) throws NSJPNegocioException;
}
