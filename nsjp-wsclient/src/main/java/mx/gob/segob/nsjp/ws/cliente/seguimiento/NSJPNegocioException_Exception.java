
package mx.gob.segob.nsjp.ws.cliente.seguimiento;

import javax.xml.ws.WebFault;


/**
 * This class was generated by Apache CXF 2.4.1
 * 2011-09-01T14:08:14.359-05:00
 * Generated source version: 2.4.1
 */

@WebFault(name = "NSJPNegocioException", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/")
public class NSJPNegocioException_Exception extends Exception {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = -3519624139843859097L;
	private mx.gob.segob.nsjp.ws.cliente.seguimiento.NSJPNegocioException nsjpNegocioException;

    public NSJPNegocioException_Exception() {
        super();
    }
    
    public NSJPNegocioException_Exception(String message) {
        super(message);
    }
    
    public NSJPNegocioException_Exception(String message, Throwable cause) {
        super(message, cause);
    }

    public NSJPNegocioException_Exception(String message, mx.gob.segob.nsjp.ws.cliente.seguimiento.NSJPNegocioException nsjpNegocioException) {
        super(message);
        this.nsjpNegocioException = nsjpNegocioException;
    }

    public NSJPNegocioException_Exception(String message, mx.gob.segob.nsjp.ws.cliente.seguimiento.NSJPNegocioException nsjpNegocioException, Throwable cause) {
        super(message, cause);
        this.nsjpNegocioException = nsjpNegocioException;
    }

    public mx.gob.segob.nsjp.ws.cliente.seguimiento.NSJPNegocioException getFaultInfo() {
        return this.nsjpNegocioException;
    }
}