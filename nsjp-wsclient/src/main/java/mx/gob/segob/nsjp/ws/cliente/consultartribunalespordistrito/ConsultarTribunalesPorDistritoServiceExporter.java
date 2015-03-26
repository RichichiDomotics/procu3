package mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.FaultAction;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 2.4.2
 * 2012-02-23T17:57:18.949-06:00
 * Generated source version: 2.4.2
 * 
 */
@WebService(targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", name = "ConsultarTribunalesPorDistritoServiceExporter")
@XmlSeeAlso({ObjectFactory.class})
public interface ConsultarTribunalesPorDistritoServiceExporter {

    @WebResult(name = "return", targetNamespace = "")
    @Action(input = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarAgenciasPorDistritoRequest", output = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarAgenciasPorDistritoResponse", fault = {@FaultAction(className = NSJPNegocioException_Exception.class, value = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarAgenciasPorDistrito/Fault/NSJPNegocioException")})
    @RequestWrapper(localName = "consultarAgenciasPorDistrito", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.ConsultarAgenciasPorDistrito")
    @WebMethod
    @ResponseWrapper(localName = "consultarAgenciasPorDistritoResponse", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.ConsultarAgenciasPorDistritoResponse")
    public java.util.List<mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.CatDiscriminanteWSDTO> consultarAgenciasPorDistrito(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Long arg0
    ) throws NSJPNegocioException_Exception;

    @WebResult(name = "return", targetNamespace = "")
    @Action(input = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarTribunalesPorDistritoRequest", output = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarTribunalesPorDistritoResponse", fault = {@FaultAction(className = NSJPNegocioException_Exception.class, value = "http://ws.service.nsjp.segob.gob.mx/ConsultarTribunalesPorDistritoServiceExporter/consultarTribunalesPorDistrito/Fault/NSJPNegocioException")})
    @RequestWrapper(localName = "consultarTribunalesPorDistrito", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.ConsultarTribunalesPorDistrito")
    @WebMethod
    @ResponseWrapper(localName = "consultarTribunalesPorDistritoResponse", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.ConsultarTribunalesPorDistritoResponse")
    public java.util.List<mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito.CatDiscriminanteWSDTO> consultarTribunalesPorDistrito(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Long arg0
    ) throws NSJPNegocioException_Exception;
}
