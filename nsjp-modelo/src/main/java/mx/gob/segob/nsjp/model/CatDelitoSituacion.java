/**
 * 
 */
package mx.gob.segob.nsjp.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author EduardoAD
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "SituacionImputado")
public class CatDelitoSituacion implements java.io.Serializable{
	// Fields
	private Long situacionImputadoId;
	private Long prioridad;
    private String descripcion;
    
    // Constructors
    /** default constructor */
	public CatDelitoSituacion() {
	}
	/** minimal constructor */

	public CatDelitoSituacion(Long situacionImputadoId, Long prioridad,
			String descripcion) {
		super();
		this.situacionImputadoId = situacionImputadoId;
		this.prioridad = prioridad;
		this.descripcion = descripcion;
	}
	
	// Getters - Setters
	/**
	 * M�todo de acceso al campo catDelitoCausaId.
	 * @return El valor del campo catDelitoCausaId
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "situacionImputado_id", unique = true, nullable = false, precision = 18, scale = 0)
	public Long getSituacionImputadoId() {
		return situacionImputadoId;
	}
	public void setSituacionImputadoId(Long situacionImputadoId) {
		this.situacionImputadoId = situacionImputadoId;
	}
	
	@Column(name = "prioridad", nullable = false, length = 10)
	public Long getPrioridad() {
		return prioridad;
	}
	public void setPrioridad(Long prioridad) {
		this.prioridad = prioridad;
	}
	
	@Column(name = "descripcion", nullable = false, length = 150)
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
}
