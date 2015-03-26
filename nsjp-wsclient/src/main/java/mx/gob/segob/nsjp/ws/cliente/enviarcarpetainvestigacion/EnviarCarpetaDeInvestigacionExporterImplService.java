package mx.gob.segob.nsjp.ws.cliente.enviarcarpetainvestigacion;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;
import javax.xml.ws.Service;

/**
 * This class was generated by Apache CXF 2.4.1
 * 2011-11-15T18:21:16.437-06:00
 * Generated source version: 2.4.1
 * 
 */
@WebServiceClient(name = "EnviarCarpetaDeInvestigacionExporterImplService", 
                  wsdlLocation = "http://localhost:8080/nsjp-web/EnviarCarpetaDeInvestigacionExporterImplService?wsdl",
                  targetNamespace = "http://impl.ws.service.nsjp.segob.gob.mx/") 
public class EnviarCarpetaDeInvestigacionExporterImplService extends Service {

    public final static URL WSDL_LOCATION;

    public final static QName SERVICE = new QName("http://impl.ws.service.nsjp.segob.gob.mx/", "EnviarCarpetaDeInvestigacionExporterImplService");
    public final static QName EnviarCarpetaDeInvestigacionExporterImplPort = new QName("http://impl.ws.service.nsjp.segob.gob.mx/", "EnviarCarpetaDeInvestigacionExporterImplPort");
    static {
        URL url = null;
        try {
            url = new URL("http://localhost:8080/nsjp-web/EnviarCarpetaDeInvestigacionExporterImplService?wsdl");
        } catch (MalformedURLException e) {
            java.util.logging.Logger.getLogger(EnviarCarpetaDeInvestigacionExporterImplService.class.getName())
                .log(java.util.logging.Level.INFO, 
                     "Can not initialize the default wsdl from {0}", "http://localhost:8080/nsjp-web/EnviarCarpetaDeInvestigacionExporterImplService?wsdl");
        }
        WSDL_LOCATION = url;
    }

    public EnviarCarpetaDeInvestigacionExporterImplService(URL wsdlLocation) {
        super(wsdlLocation, SERVICE);
    }

    public EnviarCarpetaDeInvestigacionExporterImplService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public EnviarCarpetaDeInvestigacionExporterImplService() {
        super(WSDL_LOCATION, SERVICE);
    }
    
    /**
     *
     * @return
     *     returns EnviarCarpetaDeInvestigacionExporter
     */
    @WebEndpoint(name = "EnviarCarpetaDeInvestigacionExporterImplPort")
    public EnviarCarpetaDeInvestigacionExporter getEnviarCarpetaDeInvestigacionExporterImplPort() {
        return super.getPort(EnviarCarpetaDeInvestigacionExporterImplPort, EnviarCarpetaDeInvestigacionExporter.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns EnviarCarpetaDeInvestigacionExporter
     */
    @WebEndpoint(name = "EnviarCarpetaDeInvestigacionExporterImplPort")
    public EnviarCarpetaDeInvestigacionExporter getEnviarCarpetaDeInvestigacionExporterImplPort(WebServiceFeature... features) {
        return super.getPort(EnviarCarpetaDeInvestigacionExporterImplPort, EnviarCarpetaDeInvestigacionExporter.class, features);
    }

}
