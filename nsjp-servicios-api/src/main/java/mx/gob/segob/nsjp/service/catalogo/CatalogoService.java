/**
 *
 * Nombre del Programa : CatalogoService.java                                    
 * Autor                            : Vladimir Aguirre
 * Compania                    : Ultrasist                                                
 * Proyecto                      : NSJP                    Fecha: 30/03/2011 
 * Marca de cambio        : N/A                                                     
 * Descripcion General    : Interface para el servicio que obtiene catalogos                      
 * Programa Dependiente  :N/A                                                      
 * Programa Subsecuente :N/A                                                      
 * Cond. de ejecucion        :N/A                                                      
 * Dias de ejecucion          :N/A                             Horario: N/A       
 *                              MODIFICACIONES                                       
 *------------------------------------------------------------------------------           
 * Autor                       :N/A                                                           
 * Compania               :N/A                                                           
 * Proyecto                 :N/A                                   Fecha: N/A       
 * Modificacion           :N/A                                                           
 *------------------------------------------------------------------------------           
 */
package mx.gob.segob.nsjp.service.catalogo;

import java.util.List;

import mx.gob.segob.nsjp.comun.enums.catalogo.Catalogos;
import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dto.catalogo.CatAreasNegocioDTO;
import mx.gob.segob.nsjp.dto.catalogo.CatDelitoDTO;
import mx.gob.segob.nsjp.dto.catalogo.CatFaltaAdministrativaDTO;
import mx.gob.segob.nsjp.dto.catalogo.CatalogoDTO;
import mx.gob.segob.nsjp.dto.configuracion.ConfInstitucionDTO;

/**
 * Interface del servicio para recuperar los catalgoos.
 * 
 * @author vaguirre
 * 
 */
public interface CatalogoService {
    /**
     * Recupera un catalogo.
     * 
     * @param cat
     *            Identificador del catalogo a recuperar.
     * @return Los registros del catalogo (llave y valor).
     * @throws NSJPNegocioException
     *             En caso de no poder recuperar el catalogo.
     * 
     */
    List<CatalogoDTO> recuperarCatalogo(Catalogos cat)
            throws NSJPNegocioException;

    /**
     * Recupera un catalogo con todas las columnas del catalogo.
     * 
     * @param cat
     *            Identificador del catalogo a recuperar.
     * @return Los registros del catalogo (llave, valor y dem�s columnas).
     * @throws NSJPNegocioException
     *             En caso de no poder recuperar el catalogo.
     * 
     */
    List<CatalogoDTO> recuperarCatalogoCompleto(Catalogos cat)
            throws NSJPNegocioException;

    /**
     * Recupera un catalogo dependiente
     * 
     * @param catHijo
     *            Identificador del catalogo a recuperar.
     * @param idValorPadre
     *            Valor de la llave del registro del catalogo padre
     * @return Los registros del catalogo asociado al catalogo padre
     * @throws NSJPNegocioException
     *             En caso de no poder recuperar el catalogo.
     */
    List<CatalogoDTO> recuperarCatalogoDependiente(Catalogos catHijo,
            Long idValorPadre) throws NSJPNegocioException;
    /**
     * Recupera la lista de asentamientos que cumplan con los criterios. <br>
     * Si alg�n criterio es <code>null</code> no se tomar� en cuenta para el
     * filtrado. <br>
     * Al menos un filtro tiene que ser diferente de <code>null</code>.
     * 
     * @param idMpio
     * @param idCiudad
     * @param idTipoAsentamiento
     * @return
     * @throws NSJPNegocioException
     *             Lanzada en caso de que los tres filtros sean
     *             <code>null</code>.
     */
    List<CatalogoDTO> consultarAsentamiento(Long idMpio, Long idCiudad,
            Long idTipoAsentamiento) throws NSJPNegocioException;
    
    /**
     * COnsulta catalogo de delitos.
     * @return Lista de delitos
     * @throws NSJPNegocioException
     */
    List<CatDelitoDTO> consultarDelito() throws NSJPNegocioException;
    
    List<CatFaltaAdministrativaDTO> consultarCatalogoFaltaAdministrativa() throws NSJPNegocioException;

    /**
     * Servicio que se encarga de recuperar el cat�logo de delitos por cualquiera, 
     * o combinaci�n, de los siguientes filtros:
     * -catDelitoId
     * -claveDelito
     * -nombre-esGrave
     * -esAccionPenPriv
     * 
     * @param catDelitoFiltro
     * @return
     * @throws NSJPNegocioException
     */
    List<CatDelitoDTO> consultarCatDelitoPorFilro(CatDelitoDTO catDelitoFiltroDTO) throws NSJPNegocioException;
   
    /**
     * Servicio que se encarga de recuperar el cat�logo de delitos exceptu�ndo los que est�n
     * relacionados con el n�mero de expediente en el grid
     * 
     * @param numExpId
     * @return
     * @throws NSJPNegocioException
     */    
    List<CatDelitoDTO>  consultarDelitosSinIdsGrid(String idsGrid) throws NSJPNegocioException;
    
    /**
     * Servicio que se encarga de recuperar el cat�logo de delitos exceptu�ndo los que est�n
     * relacionados con el n�mero de expediente en el grid
     * 
     * @param numExpId
     * @return
     * @throws NSJPNegocioException
     */    
    List<CatDelitoDTO>  consultarDelitoIdSeleccionados(String idsGrid) throws NSJPNegocioException;
    
    /**
	 * Consulta un catDelito por su id
	 * @param catDelitoId
	 * @return
	 * @throws NSJPNegocioException
	 */
	CatDelitoDTO consultarCatDelitoPorId(Long catDelitoId) throws NSJPNegocioException;
	
	/**
	 * Consulta un catAreaNegocio por su id
	 * @param catAreaNegId
	 * @return
	 * @throws NSJPNegocioException
	 */
	CatAreasNegocioDTO consultarCatAreaNegocioPorId(Long catAreaNegId) throws NSJPNegocioException;
	
	/**
	 * Servicio que actualiza o guarda un CatDelito
	 * 
	 * @param catDelitoDto si la clave es difenrente de 0, se guarda el objeto, si no se busca y se actualiza
	 * @return
	 * @throws NSJPNegocioException
	 */
	CatDelitoDTO guardarActualizarCatDelito(CatDelitoDTO catDelitoDto) throws NSJPNegocioException;
	
	/**
	 * Servicio que actualiza o guarda un CatAreasNegocioDTO
	 * @param CatAreasNegocioDto
	 * @return
	 * @throws NSJPNegocioException
	 */
	CatAreasNegocioDTO guardarActualizarCatAreasNegocio(CatAreasNegocioDTO CatAreasNegocioDto) throws NSJPNegocioException;

	/**
	 * Servicio que elimina un objeto catDelitoDto por su id
	 * @param catDelitoId
	 * @return
	 */
	Long eliminarCatDelito(Long catDelitoId) throws NSJPNegocioException;
	
	/**
	 * Servicio que elimina un objeto catAreasNegocio por su id
	 * @param catAreasNegocioId
	 * @return valor long con la respuesta de eliminacion
	 * @throws NSJPNegocioException
	 */
	Long eliminarCatAreasNegocio(Long catAreasNegocioId) throws NSJPNegocioException;
	
	
	/**
	 * Permite eliminar un Distrito siempre y cuando no tenga relaciones
	 * @param idCatDistrito
	 * @return
	 * @throws NSJPNegocioException
	 */
	public Long eliminarDistrito(Long idCatDistrito) throws NSJPNegocioException;
	
	/**
	 * Permite eliminar una agencia siempre y cuando no tenga relaciones
	 * @param idAgencia
	 * @return
	 * @throws NSJPNegocioException
	 */
	public Long eliminarAgencia(Long idAgencia)	throws NSJPNegocioException;
	
	/**
	 * Permite consultar una falta Administrativa por identificador
	 * @param idFaltaAdministrativa
	 * @return
	 * @throws NSJPNegocioException 
	 */
	public CatFaltaAdministrativaDTO consultarFaltaAdministrativa(Long idFaltaAdministrativa) throws NSJPNegocioException;
	
	/**
	 * Permite consultar un Delito en base a su identificador
	 * @param idDelito
	 * @return
	 * @throws NSJPNegocioException
	 */
	public CatDelitoDTO consultarDelito(Long idDelito) throws NSJPNegocioException;
	
	/**
	 * Permite consultar Institucion por clave
	 * @param clave
	 * @return
	 * @throws NSJPNegocioException
	 */
	public ConfInstitucionDTO consultarIntitucionPorClave(String clave) throws NSJPNegocioException;
	
}
