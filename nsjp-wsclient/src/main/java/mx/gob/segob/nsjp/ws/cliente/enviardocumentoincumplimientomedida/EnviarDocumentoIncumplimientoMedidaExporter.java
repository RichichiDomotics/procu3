package mx.gob.segob.nsjp.ws.cliente.enviardocumentoincumplimientomedida;

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
 * This class was generated by Apache CXF 2.4.1
 * 2011-11-03T20:06:02.132-06:00
 * Generated source version: 2.4.1
 * 
 */
@WebService(targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", name = "EnviarDocumentoIncumplimientoMedidaExporter")
@XmlSeeAlso({ObjectFactory.class})
public interface EnviarDocumentoIncumplimientoMedidaExporter {

    @WebResult(name = "return", targetNamespace = "")
    @Action(input = "http://ws.service.nsjp.segob.gob.mx/EnviarDocumentoIncumplimientoMedidaExporter/enviarDocumentoDeIncumplimientoDeMedidaRequest", output = "http://ws.service.nsjp.segob.gob.mx/EnviarDocumentoIncumplimientoMedidaExporter/enviarDocumentoDeIncumplimientoDeMedidaResponse", fault = {@FaultAction(className = NSJPNegocioException_Exception.class, value = "http://ws.service.nsjp.segob.gob.mx/EnviarDocumentoIncumplimientoMedidaExporter/enviarDocumentoDeIncumplimientoDeMedida/Fault/NSJPNegocioException")})
    @RequestWrapper(localName = "enviarDocumentoDeIncumplimientoDeMedida", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.enviardocumentoincumplimientomedida.EnviarDocumentoDeIncumplimientoDeMedida")
    @WebMethod
    @ResponseWrapper(localName = "enviarDocumentoDeIncumplimientoDeMedidaResponse", targetNamespace = "http://ws.service.nsjp.segob.gob.mx/", className = "mx.gob.segob.nsjp.ws.cliente.enviardocumentoincumplimientomedida.EnviarDocumentoDeIncumplimientoDeMedidaResponse")
    public java.lang.Long enviarDocumentoDeIncumplimientoDeMedida(
        @WebParam(name = "arg0", targetNamespace = "")
        mx.gob.segob.nsjp.ws.cliente.enviardocumentoincumplimientomedida.DocumentoWSDTO arg0,
        @WebParam(name = "arg1", targetNamespace = "")
        java.lang.String arg1,
        @WebParam(name = "arg2", targetNamespace = "")
        java.lang.String arg2
    ) throws NSJPNegocioException_Exception;
}
