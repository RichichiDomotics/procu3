/**
 * Nombre del Programa : AsignarNumeroExpedienteService.java
 * Autor                            : cesar
 * Compania                    : Ultrasist
 * Proyecto                      : NSJP                    Fecha: 15 Apr 2011
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
package mx.gob.segob.nsjp.service.expediente;

import java.util.List;

import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.dto.expediente.ExpedienteDTO;
import mx.gob.segob.nsjp.dto.expediente.TurnoDTO;
import mx.gob.segob.nsjp.dto.usuario.UsuarioDTO;

/**
 * Describir el objetivo de la clase con punto al final.
 * 
 * @version 1.0
 * @author cesar
 * 
 */
public interface AsignarNumeroExpedienteService {

	/**
     * Genera un nuevo n�mero de expediente.<br>
     * Al generar el n�mero guarda un expediente en la BD.
     * 
     * 
     * @param expedienteDTO
     *            Obligatorio la <b>fechaApertura</b>. <br>
     *            Opcional <b>casoDTO</b>.<br>
     *            Si <b>expedienteId</b> es <code>null</code> se generar� un
     *            Expediente completo (con sU respectuvo N�mero), en caso
     *            contrario s�lo se crear� un N�mero de expediente asociado el
     *            expediente.
     * 
     * @return <ul>
     *         <li>expedienteId</il>
     *         <li>numeroExpediente</il>
     *         <li>fechaApertura</il>
     *         </ul>
     * @throws NSJPNegocioException
     *             En caso de ocurrir alg�n error.
     */
    public ExpedienteDTO asignarNumeroExpediente(ExpedienteDTO expedienteDTO)
            throws NSJPNegocioException;

    /**
     * Autoasigna los nuevos n�meros de expediente al usuario en sesi�n
     * @param listaExpedientes
     * @return
     * @throws NSJPNegocioException
     */
    public Boolean asignarNumerosDeExpediente(List<ExpedienteDTO> listaExpedientes)
            throws NSJPNegocioException;

    /**
     * 
     * @param tipoExpediente
     * @return
     * @throws NSJPNegocioException
     */
    public ExpedienteDTO asignarNumeroExpedienteTipo(ExpedienteDTO expedienteDTO)
            throws NSJPNegocioException;

    /**
     * Genera un nuevo n�mero de expediente a partir de un turno.<br>
     * Al generar el n�mero guarda un expediente en la BD.
     * 
     * @param TurnoDTO
     *            Obligatorios <b>turnoId, usuario.idUsuario</b>.
     * @return <ul>
     *         <li>expedienteId</il>
     *         <li>numeroExpediente</il>
     *         <li>fechaApertura</il>
     *         </ul>
     * @throws NSJPNegocioException
     *             En caso de ocurrir alg�n error.
     */
    public ExpedienteDTO asignarNumeroExpediente(TurnoDTO turno)
            throws NSJPNegocioException;

	public ExpedienteDTO asignarNumeroExpedientePenal(TurnoDTO turno)
			throws NSJPNegocioException;
    /**
     * Asigna un numero de expediente a una solicitud
     * @param numeroExpedienteId Numero de expediente a asignar
     * @param solicitudId Solicitud a la cu�l ser� asignado
     */
    void asignarNumeroExpedienteASolicitud(Long numeroExpedienteId,Long solicitudId) throws NSJPNegocioException;

	public ExpedienteDTO asignarNumeroExpedienteDefensoria(
			ExpedienteDTO inputExpediente) throws NSJPNegocioException;

	
	/**
	 * Servicio para crear un nuevo de Auditor�a, que permita asignar un nuevo n�mero de expediente, n�mero de auditor�a, 
	 * considerando el registro en la relaci�n: RelNumExpedienteAuditoria
	 * 
	 * @param listaNumeroExpedienteAuditados
	 * @return
	 * @throws NSJPNegocioException
	 */
	List<ExpedienteDTO>  asignarNumeroExpedienteAuditoria(List<ExpedienteDTO> listaNumeroExpedienteAuditados) throws NSJPNegocioException;
	
	/**
	 * Servicio que permite la creaci�n de un nuevo expediente, su numero Expediente "Carpeta de Ejecucion de la Sentencia"
	 * A partir del ID se obtiene el Area, funcionario, numeroExpedientePadre de la CAusa.
	 * Para generar el nuevo expediente de las sentencia, es necesario, pasar:
	 * Areas, CausaPadre (NumeroExpedienteId), TipoExpediente, Esxtatus, Funcionario y el ExpedienteID=null.
	 * TODO GBP Falta pasar la informacion de acuerdo al CU. Y Asginarlo cuando se tenga un mandamiento de tipo Sentencia.
	 * 
	 * @param expedienteId
	 * @return
	 * @throws NSJPNegocioException
	 */
	ExpedienteDTO asignarNumeroExpedienteCarpetaEjecucion(Long expedienteId) throws NSJPNegocioException;
	
	/**
	 * M&eacute;todo que lleva a cabo la generaci&oacute;n de un n&uacute;mero de expediente alterno en base al
	 * usuario firmado. Y lleva a cabo la actualizaci&oacute;n del n&uacute;mero de expediente alterno.
	 * @param usuario - El usuario del cual se va a obtener la unidad y el discriminante sobre el cual se va a 
	 * 					generar el n&uacute;mero alterno del expediente.
	 * @param expediente - El expediente del cual se va a actualizar el n&uacute;mero de expediente alterno.   
	 * @return numExpAlterno - el n&uacute;mero de expediente alterno generado.
	 * @throws NSJPNegocioException - En el caso de que el usuario pasado como par&aacute;metro, no cuente con un 
	 * 								  distrito asociado.
	 */
	public String obtenerNumeroExpedienteAlterno (UsuarioDTO usuario, ExpedienteDTO expediente) throws NSJPNegocioException;
	
	/**
	 * M&eacute;todo que lleva a cabo la generaci&oacute;n de un n&uacute;mero de expediente alterno en base al
	 * usuario firmado. La unidad para el n�mero de expediente alterno, es espec�ficamente visitadur�a
	 * @param usuario
	 * @param expediente
	 * @return
	 * @throws NSJPNegocioException
	 */
	public String obtenerNumeroExpedienteAlternoUnidadVisitaduria (UsuarioDTO usuario, ExpedienteDTO expediente) throws NSJPNegocioException;
		
	/**
	 * M&eacute;todo para consultar el numero de expediente Alterno
	 * @param usuario
	 * @param expediente
	 * @return El numero de expediente alterno, si el parametro esta encendido en BD
	 * @throws NSJPNegocioException
	 */
	public String consultarNumeroExpedienteAlterno (ExpedienteDTO expediente) throws NSJPNegocioException;

	
	/**
	 * M&eactute para obtener el n�mero de expediente, si se encuentra un n�mero de expediente con dicho expedienteId
	 * y �rea, se mantiene, en caso contrario, se genera el n�mero de expediente alterno.
	 * @param expediente
	 * @param areaId
	 * @return
	 * @throws NSJPNegocioException
	 */
	public String obtenerNumExpXExpIdAreaId(ExpedienteDTO expediente, Long areaId) throws NSJPNegocioException;
}
