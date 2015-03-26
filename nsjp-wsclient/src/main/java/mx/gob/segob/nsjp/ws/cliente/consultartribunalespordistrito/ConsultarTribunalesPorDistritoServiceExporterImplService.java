package mx.gob.segob.nsjp.ws.cliente.consultartribunalespordistrito;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;
import javax.xml.ws.Service;

/**
 * This class was generated by Apache CXF 2.4.2
 * 2012-02-23T17:57:18.958-06:00
 * Generated source version: 2.4.2
 * 
 */
@WebServiceClient(name = "ConsultarTribunalesPorDistritoServiceExporterImplService", 
                  wsdlLocation = "http://localhost:8080/nsjp-web/ConsultarTribunalesPorDistritoServiceExporterImplService?wsdl",
                  targetNamespace = "http://impl.ws.service.nsjp.segob.gob.mx/") 
public class ConsultarTribunalesPorDistritoServiceExporterImplService extends Service {

    public final static URL WSDL_LOCATION;

    public final static QName SERVICE = new QName("http://impl.ws.service.nsjp.segob.gob.mx/", "ConsultarTribunalesPorDistritoServiceExporterImplService");
    public final static QName ConsultarTribunalesPorDistritoServiceExporterImplPort = new QName("http://impl.ws.service.nsjp.segob.gob.mx/", "ConsultarTribunalesPorDistritoServiceExporterImplPort");
    static {
        URL url = null;
        try {
            url = new URL("http://localhost:8080/nsjp-web/ConsultarTribunalesPorDistritoServiceExporterImplService?wsdl");
        } catch (MalformedURLException e) {
            java.util.logging.Logger.getLogger(ConsultarTribunalesPorDistritoServiceExporterImplService.class.getName())
                .log(java.util.logging.Level.INFO, 
                     "Can not initialize the default wsdl from {0}", "http://localhost:8080/nsjp-web/ConsultarTribunalesPorDistritoServiceExporterImplService?wsdl");
        }
        WSDL_LOCATION = url;
    }

    public ConsultarTribunalesPorDistritoServiceExporterImplService(URL wsdlLocation) {
        super(wsdlLocation, SERVICE);
    }

    public ConsultarTribunalesPorDistritoServiceExporterImplService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public ConsultarTribunalesPorDistritoServiceExporterImplService() {
        super(WSDL_LOCATION, SERVICE);
    }
    

    /**
     *
     * @return
     *     returns ConsultarTribunalesPorDistritoServiceExporter
     */
    @WebEndpoint(name = "ConsultarTribunalesPorDistritoServiceExporterImplPort")
    public ConsultarTribunalesPorDistritoServiceExporter getConsultarTribunalesPorDistritoServiceExporterImplPort() {
        return super.getPort(ConsultarTribunalesPorDistritoServiceExporterImplPort, ConsultarTribunalesPorDistritoServiceExporter.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns ConsultarTribunalesPorDistritoServiceExporter
     */
    @WebEndpoint(name = "ConsultarTribunalesPorDistritoServiceExporterImplPort")
    public ConsultarTribunalesPorDistritoServiceExporter getConsultarTribunalesPorDistritoServiceExporterImplPort(WebServiceFeature... features) {
        return super.getPort(ConsultarTribunalesPorDistritoServiceExporterImplPort, ConsultarTribunalesPorDistritoServiceExporter.class, features);
    }

}
