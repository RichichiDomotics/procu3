
package mx.gob.segob.nsjp.ws.cliente.solicitudaudiencia;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para embarcacionWSDTO complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="embarcacionWSDTO">
 *   &lt;complexContent>
 *     &lt;extension base="{http://ws.service.nsjp.segob.gob.mx/}objetoWSDTO">
 *       &lt;sequence>
 *         &lt;element name="color" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="marca" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="matricula" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="noMotor" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="noSerie" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nombreEmbarcacion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="paisOrigen" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="subMarca" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="tipoEmbarcacion" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "embarcacionWSDTO", propOrder = {
    "color",
    "marca",
    "matricula",
    "noMotor",
    "noSerie",
    "nombreEmbarcacion",
    "paisOrigen",
    "subMarca",
    "tipoEmbarcacion"
})
public class EmbarcacionWSDTO
    extends ObjetoWSDTO
{

    protected Long color;
    protected Long marca;
    protected String matricula;
    protected String noMotor;
    protected String noSerie;
    protected String nombreEmbarcacion;
    protected Long paisOrigen;
    protected Long subMarca;
    protected Long tipoEmbarcacion;

    /**
     * Obtiene el valor de la propiedad color.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getColor() {
        return color;
    }

    /**
     * Define el valor de la propiedad color.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setColor(Long value) {
        this.color = value;
    }

    /**
     * Obtiene el valor de la propiedad marca.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getMarca() {
        return marca;
    }

    /**
     * Define el valor de la propiedad marca.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setMarca(Long value) {
        this.marca = value;
    }

    /**
     * Obtiene el valor de la propiedad matricula.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMatricula() {
        return matricula;
    }

    /**
     * Define el valor de la propiedad matricula.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMatricula(String value) {
        this.matricula = value;
    }

    /**
     * Obtiene el valor de la propiedad noMotor.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNoMotor() {
        return noMotor;
    }

    /**
     * Define el valor de la propiedad noMotor.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNoMotor(String value) {
        this.noMotor = value;
    }

    /**
     * Obtiene el valor de la propiedad noSerie.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNoSerie() {
        return noSerie;
    }

    /**
     * Define el valor de la propiedad noSerie.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNoSerie(String value) {
        this.noSerie = value;
    }

    /**
     * Obtiene el valor de la propiedad nombreEmbarcacion.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNombreEmbarcacion() {
        return nombreEmbarcacion;
    }

    /**
     * Define el valor de la propiedad nombreEmbarcacion.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNombreEmbarcacion(String value) {
        this.nombreEmbarcacion = value;
    }

    /**
     * Obtiene el valor de la propiedad paisOrigen.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getPaisOrigen() {
        return paisOrigen;
    }

    /**
     * Define el valor de la propiedad paisOrigen.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setPaisOrigen(Long value) {
        this.paisOrigen = value;
    }

    /**
     * Obtiene el valor de la propiedad subMarca.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getSubMarca() {
        return subMarca;
    }

    /**
     * Define el valor de la propiedad subMarca.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setSubMarca(Long value) {
        this.subMarca = value;
    }

    /**
     * Obtiene el valor de la propiedad tipoEmbarcacion.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getTipoEmbarcacion() {
        return tipoEmbarcacion;
    }

    /**
     * Define el valor de la propiedad tipoEmbarcacion.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setTipoEmbarcacion(Long value) {
        this.tipoEmbarcacion = value;
    }

}
