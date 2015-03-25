/**
 * Nombre del Programa : ConfActividadDocumentoDAO.java
 * Autor                            : Jacob Lobaco
 * Compania                         : Ultrasist
 * Proyecto                         : NSJP                    Fecha: 06-jul-2011
 * Marca de cambio        : N/A
 * Descripcion General    : N/A
 * Programa Dependient    :N/A
 * Programa Subsecuente   :N/A
 * Cond. de ejecucion     :N/A
 * Dias de ejecucion      :N/A                                Horario: N/A
 *                              MODIFICACIONES
 *------------------------------------------------------------------------------
 * Autor                            :N/A
 * Compania                         :N/A
 * Proyecto                         :N/A                      Fecha: N/A
 * Modificacion           :N/A
 *------------------------------------------------------------------------------
 */
package mx.gob.segob.nsjp.dao.actividad;

import java.util.List;

import mx.gob.segob.nsjp.dao.base.GenericDao;
import mx.gob.segob.nsjp.dto.catalogo.CatalogoDTO;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.usuario.UsuarioDTO;
import mx.gob.segob.nsjp.model.ConfActividadDocumento;
import mx.gob.segob.nsjp.model.NumeroExpediente;
import mx.gob.segob.nsjp.model.Rol;
import mx.gob.segob.nsjp.model.Valor;

/**
 * 
 * @version 1.0
 * @author Jacob Lobaco
 */
public interface ConfActividadDocumentoDAO extends
        GenericDao<ConfActividadDocumento, Long> {

	/**
	 * Cosulta la configuracion de las actividades por Area (asociada al funcionario),
	 * estado del expediente (asociada al n�mero de expediente) y la Categor�a a la 
	 * que pertenece dicha actividad. Este �ltimo par�metro es opcional. 
	 * @param funcionario
	 * @param numeroExpediente
	 * @param idCategoriaActidad
	 * @return
	 */
    List<ConfActividadDocumento> consultarConfActividadDocumento(
            Long jerarquiaOrganizacionalId, NumeroExpediente numeroExpediente, Long idCategoriaActidad);
    


    /**
     * Consulta la Configuracion del la Actividad de Documento de acuerdo
     * a Tipo Actividad 
     * 
     * @param idTipoActividad
     * @return
     */
    ConfActividadDocumento consultaConfActividadDocumentoPorIdActividad(Long idTipoActividad);
    
    /**
     * Consultar los estados asociados a una Jerarquia Organizacional. 
     * Se hace uso de Distinc para obtener un solo dato por estatus asociado.
     *  
     * @param idJerarquiaOrganizacional
     * @return
     */
    List<Valor> consultarEstadosDistintosPorJerarquiaOrganizacional(Long idJerarquiaOrganizacional);
    
    List<ConfActividadDocumento> consultarActuacionesPorRol(Rol rol);
    
    /**
     * Consultar las Actuaciones asociadas a una Jerarquia Organizacional
     */
    
    /**
     * 
     * @param idTipoActividad
     * @param idTipoForma
     * @param jeraquia
     * @return
     */
    List<ConfActividadDocumento> consultarPorTipoActFormaAndJerarquia(Long idTipoActividad, Long idTipoForma, Long jeraquia);
    
}
