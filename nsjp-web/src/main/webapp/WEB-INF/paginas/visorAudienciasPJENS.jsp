<%@page import="mx.gob.segob.nsjp.comun.enums.leycodigo.TipoNorma"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.documento.TipoDocumento"%>
<%@page import="mx.gob.segob.nsjp.comun.constants.ConstantesGenerales"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.calidad.Calidades"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.funcionario.TipoEspecialidad"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.funcionario.Puestos"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.audiencia.EstatusAudiencia"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.audiencia.EstatusPermisosAudiencia"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.funcionario.Especialidades"%>
<%@page import="mx.gob.segob.nsjp.comun.enums.solicitud.TiposSolicitudes"%>
<%@page import="java.util.Calendar"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Atenci�n de Audiencias</title>


<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.windows-engine.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/estilos.css"  />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/layout_complex.css"  />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/multiselect/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/multiselect/style.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/multiselect/prettify.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/ui-lightness/jquery-ui-1.8.11.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/cssGrid/ui.jqgrid.css"  />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery.richtext.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery.alerts.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery.colorpicker.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery.easyaccordion.css" />

<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-1.5.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-ui-1.8.10.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/prettify.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.multiselect.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/validate/jquery.maskedinput.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/validate/mktSignup.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/ckeditor/adapters/jquery.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jqgrid/i18n/grid.locale-es.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jsGrid/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jsGrid/jquery.tablednd.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/wdCalendar/Plugins/jquery.ui.datepicker-es.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/wdCalendar/Plugins/jquery.ui.timepicker.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/wdCalendar/Plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery.windows-engine.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery.easyAccordion.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/bloqueaTecla.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/comun.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery.blockUI.js"></script>

	<!--ESTILOS PARA LAS TABS-->
	<style>
	#tabs { height: 770px; }
	.tabs-bottom { position: relative; }

	.tabs-bottom .ui-tabs-panel { height: auto; overflow: auto; }
	.tabs-bottom .ui-tabs-nav { position: absolute !important; left: 0; bottom: 0; right:0; padding: 0 0.2em 0.2em 0; }
	.tabs-bottom .ui-tabs-nav li { margin-top: -2px !important; margin-bottom: 1px !important; border-top: none; border-bottom-width: 1px; }
	.ui-tabs-selected { margin-top: -3px !important; }
	</style>

	<script type="text/javascript">

	var contextoPagina = "${pageContext.request.contextPath}";
	var audienciaConsulta;
	/**
	* Variables globales para controlar los datos de la pesta�a de programar audiencia
	*/
	var idApplet=0;
	var idPermisos=0;
	//guarda tipo de ley a consultar
	var tipoLey=0;
	//guarda el id del domicilio
	var domicilioId;
	//mes que se muestra en la caja de texto
	var mesActual;
	//anio que se muestra en la caja de texto
	var anioActual;
	//Arreglo usado como carrusel para obtener los meses
	var meses =["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
	//bandera de cambio para recorrer el carrusel de meses
	var banderaCambio=0;
	//primera consulta muestra los grids de salas
	var primeraConsulta= "true";
	//primera consulta jueces muestra los grids de jueces
	var primeraConsultaJueces= "true";
	//Datos que vienen de asignarSalaTemporalPJENA.jsp
	var datosSalaTemporal="";
	//numero de salas
	var salaTemporal="false";
	//id de la audiencia
	var idAudiencia;
	var tipoAudiencia;
	var multiselect=0;
	var fechaReal="";
	//variables para la consulta de jueces
	var horaSeleccionada="";
	var minutoSeleccionado="";
	var duracionEstimadaAudiencia="";
	var idSalaSeleccionada="";
	var idEvento=parent.audienciasid;

	// 	Enable IT By Asdrubal se agrega variable para recuperar el nombre de la audiencia
	var SalaName="";
	
	//Permite ocultar/mostrar los botones relacionados a la Notificacion
	var desactivarBotonesEnNotificaciones = true;

	/*
	*Variables para la sub ceja de Involucrados
	*/
	puestoFuncionarioSig="";

	//variable para almacenar el id de la audiencia siguiente
	var idAudienciaSiguiente=0;

	/**
	* Variables globales para controlar los datos
	*/
	var lstResolutivos = new Array();
	var idResolutivo = 0;
	//var idEventoGlob;
	var fechaGlob;
	var tipoAudGlob;
	var ubicacionGlob;
	var direccionGlob;

	//variable que almacena el nombre de las salas
	var nombreSalas=new Array();

	//Variable para controlar los ids de las salas
	var identiSala=new Array();

	var primeraFiscal=true;

	var numExpediente = parent.numExpediente;

	/**Variables ceja Individualizacion*/
	var puestoFuncionario="";
	var idWindowIngresarTestigo=1;
	var idWindowIngresarDenunciante=1;
	var numeroExpediente ="";


	/***************************
	*Variables para la ceja de Pruebas*
	*/
	var audienciaId="";

	/** Varialbles necesarias para registrar un amparo**/
	var idExpediente = 0;
	var idNumeroExpediente = 0;

	/*
	*Constantes generales para tipo de consulta
	*/
	var TIPO_CONSULTA_VICTIMA = 6;
	var TIPO_CONSULTA_DENUNCIANTE = 7;
	var TIPO_CONSULTA_TESTIGO = 3;
	
	/*Variable que contiene el estatus de la audiencia/*Enable IT ByYolo*/
	var estatusAudiencia=null;

	$(document).ready(function() {

		jQuery(document).ajaxStop(jQuery.unblockUI);

		//crea todas la tabs
		$("#tabsDetalleAudiencias").tabs();

		/*
		*LLamadas COMUN
		*/
			//Recuperamos el id de la audiencia ACTUAL
			var idEventoParcial=<%= request.getSession().getAttribute("idEvento")%>;

			if(idAudienciaSiguiente == 0){
				idAudienciaSiguiente=<%= request.getAttribute("idAudienciaSiguiente")%>;
				if(idAudienciaSiguiente == null){
					idAudienciaSiguiente = 0;
				}
				else{
					$("#tabsDetalleAudiencias" ).tabs('select', 4);
				}
			}

			if(idEventoParcial!="undefined"){
				idEvento=idEventoParcial;
			}

			idAudiencia=idEvento;
			///Para la ceja de pruebas
		audienciaId=idEvento;



			deshabilitarHabilitarComponentes("inicio");

		/*
		*LLamdas para la ceja de Detalle de Audiencia
		*/
			consultaDetalleEvento(idEvento);
			cargaImputadosAudiencia(idEvento);
			consultarJuecesDeAudiencia(idAudiencia);
			cargaImputadosProgramarAudiencia(idEvento);
			/*Se carga el grid de las solicitudes de Defensor/*Enable IT ByYolo*/
			cargaSolicitudesAudiencia(idAudiencia);
		/*
		*LLamdas para la ceja de Individualizacion
		*/
			cargaGridVictima();
			cargaGridVictimaOrg();
			cargaGridDenunciante();
			cargaGridFiscal();
			cargaGridDefensor();
			cargaGridTestigo();
			cargaGridPerito();
			cargaGridPolicia();

		/*
		*LLamdas para la ceja de Objetos
		*/
			//cargaCadenaCustodia(idEvento);

		/**********************************
		*LLamdas para la ceja Pruebas
		************************************/
			$( "#tabschildPruebasPJENS" ).tabs();

			//LLamadas para la sub ceja Datos de Pruebas
			cargaGridDatosPrueba();
			$("#tipoDatoPruebaPJENS").change(controlDatoDePrueba);
			$("#tipoMediaPruebaPJENS").change(controlMedioDePrueba);

			//LLamadas para la sub ceja de Medios de Pruebas
			cargaGridMediosDePrueba();

			//Llamadas para la sub ceja de Prueba
			cargaGridPrueba();

			/* enable IT: carga actuaciones */
			cargaActuaciones();


		/*
		*LLamdas para la ceja de Programar Audiencia
		*/

			$( "#tabschild,#tabschild2" ).tabs();

			//oculta las sub cejas de prog audiencia
			//ocultaSubCejasProgAudiencia();

			/**Sub ceja Audiencia*/

				//Le da el estilo al combo box de duracion estimada
				$("#duracionEstimadaProgramarAudiencia").multiselect({
					multiple: false,
					header: "Seleccione",
					position: {
						my: 'top',
						at: 'top'
					},
					selectedList: 1
				});

				//obtenemos la fecha actual
				mesActual='<%=(java.util.Calendar.getInstance().get(Calendar.MONTH))%>';
				anioActual='<%=(java.util.Calendar.getInstance().get(Calendar.YEAR))%>';
				var mesSeleccionado = meses[mesActual];

				//escrbimos en pantalla la fecha actual
				$('#mes').val(mesSeleccionado);
				$('#anio').val(anioActual);

				//Carga el grid de la Agenda
				cargaGridAgenda();

				//Limpia los campos
				$('#txtSalaSeleccionada').val("");
				$('#txtHoraInicioSeleccionada').val("");

			/**Sub ceja Involucrados*/

				//Oculta las pesta�as de imputado,testigo,perito y policia ministerial
				ocultaSubCejasProgAudiencia();
				//Habilita los campos de la ventana modal
				$('#cbxFuncionarioPJENS').change(habilitaCampos);

			/**Sub ceja Objetos*/
			cargaGridObjetos();
			cargaCondicion();

		/*
		*LLamdas para la ceja Resolutivos de Audiencia
		*/
			cargaGridResolutivosDeAudiencia(idEvento);
			$("#agregarResolutivoBoton").click(agregarRegistrarResolutivo);
			$("#eliminarResolutivoBoton").click(eliminarRegistroResolutivo);
			abreCodigosLeyes();
			cargaHoraCaptura();

		/*
		*LLamdas para la ceja Adiministrar Actuaciones de Audiencia
		*/
			$("#finalAudienciaOpcion").change(onSelectChangeTipo);


		/*
		*Llamada para la ceja de Documentos
		*/
		jQuery("#gridDetalleFrmPrincipal").jqGrid({
			url:'<%=request.getContextPath()%>/consultarDocumentosPorAudiencia.do?idAudiencia='+idAudiencia,
			datatype: "xml",
			colNames:['�rea del responsable','Fecha de la actividad','Nombre de la actividad','Tipo de documento','Nombre de Documento','Fecha del documento', 'Documento', 'Es Parcial'],
			colModel:[ 	{name:'area',index:'da', width:200, align:'center'},
						{name:'FechaActividad',index:'fechaActividad', width:170, align:'center', hidden:true},
						{name:'NombreActividad',index:'nombreActividad', width:400, align:'center', hidden:true},
			           	{name:'Tipo',index:'tipo', width:155, align:'center'},
						{name:'Nombre',index:'nombre', width:255, align:'center'},
			           	{name:'Fecha',index:'fecha', width:170, align:'center'},
			           	{name:'Documento',index:'documento', width:170, align:'center'},
			           	{name:'EsParcial',index:'esParcial', align:'center', hidden:true}
						],
			pager: jQuery('#pager1Documentos'),
			rowNum:10,
			rowList:[10,20,30,40,50,60],
			autowidth: false,
			width:1100,
			sortname: 'turno',
			viewrecords: true,
			id: 'divgrid',
			ondblClickRow: function(id){
				var retd = jQuery("#gridDetalleFrmPrincipal").jqGrid('getRowData',id);
				if(retd.EsParcial){
					noEsParcial = retd.EsParcial.indexOf('false');
					if(noEsParcial > 0){
						consultaPDF(id);
					}
					else{
						numExp = $("#numExpPJENS").val();
		    		    $.newWindow({id:"iframewindowGenerarActaAudiencia", statusBar: true, posx:200,posy:50,width:1140,height:400,title:retd.Nombre, type:"iframe"});
		    		    $.updateWindowContent("iframewindowGenerarActaAudiencia",'<iframe src="<%= request.getContextPath() %>/generarDocumentoSinCaso.do?documentoId='+id+'&numeroUnicoExpediente='+numExp+'&esconderArbol=1&idAudiencia='+idAudiencia+'" width="1140" height="400" />');
					}
				}

			},
			sortorder: "desc"
		}).navGrid('#pager1Documentos',{edit:false,add:false,del:false});
		$("#gview_gridDetalleFrmPrincipal .ui-jqgrid-bdiv").css('height', '500px');

//////////////////////FUNCIONALIDAD DESCONOCIDA
		$("#tabs-2").hide();
		$("#rowDomicilioNotif").hide();
		$("#cbxPais").val(10);
		onSelectChangePais();
		//$('#validarNotificacion').bind('click',mostrarDetallePersona);

		//Se agrega la funcion solicitarDefensor
		$('#solicitarBoton').bind('click', solicitarDefensor);


		/*Carga Actuaciones */
		$("#cbxAccionesTab").change(function(e){
			seleccionaActuacion();
		});

		
	});//FIN ON READY


//**********************************************************FUNCIONALIDAD COMUN A TODAS LAS CEJAS**********************************************************\

	/*
	*Funcion que cierra la ventana visor de documentos
	*/
	function cerrarVentanaDocumento(){
		var pantalla ="iframewindowGenerarActaAudiencia";
		$.closeWindow(pantalla);
	}

	function documentoGenerado(){
		//funcion para incluir alguna accion despues de haber sido generado el archivo digital (guardado definitivo)
	}

	/**
	*Funcion para deshabilitar los botones de designar
	*Juez manualmente y autom�ticamente, Guardar y Designar Sala Temporal
	*/
	function deshabilitarHabilitarComponentes(accion){

		if(accion == "inicio"){

			$('#btnAsignarJuezManual').attr('disabled',true);
			$('#btnAsignarJuezAuto').attr('disabled',true);
			$('#btnGuardarAudiencia').attr('disabled',true);
			$('#btnDesignar').attr('disabled',true);
			$('#duracionEstimadaProgramarAudiencia').multiselect('disable');
		}
		if(accion == "horarioSala"){
			$('#btnAsignarJuezManual').attr('disabled',false);
			$('#btnAsignarJuezAuto').attr('disabled',false);
			//$('txtSalaSeleccionada').attr('disabled',false);
		}

		if(accion == "seleccionFecha"){
			$('#btnDesignar').attr('disabled',false);
			$('#btnAsignarJuezManual').attr('disabled',true);
			$('#btnAsignarJuezAuto').attr('disabled',true);
			$('#btnGuardarAudiencia').attr('disabled',true);
			$('#duracionEstimadaProgramarAudiencia').multiselect('enable');
		}

		if(accion == "designarSala"){
			$('#btnDesignar').attr('disabled',true);
			$('#btnAsignarJuezManual').attr('disabled',false);
			$('#btnAsignarJuezAuto').attr('disabled',false);
			for (i=0;i<numeroDeSalas;i++){
				salaId = identiSala[i];
				$('#gridSalasPJENA'+salaId).unbind('click');
			}
			$('#duracionEstimadaProgramarAudiencia').multiselect('disable');
		}
		if(accion == "juez"){
			$('#btnAsignarJuezManual').attr('disabled',true);
			$('#btnAsignarJuezAuto').attr('disabled',true);
			$('#btnDesignar').attr('disabled',true);
			$("#gridAgendaPJENA").unbind('click');
			$('#duracionEstimadaProgramarAudiencia').multiselect('disable');
			$('#btnAtrasMes').attr('disabled',true);
			$('#btnAdelanteMes').attr('disabled',true);
			$('#juezSustituto').attr('disabled',true);
			for (i=0;i<numeroDeSalas;i++){
				salaId = identiSala[i];
				$('#gridSalasPJENA'+salaId).unbind('click');
			}
			$('#btnGuardarAudiencia').attr('disabled',false);
		}
	}

	function invocacionSolicitudJAVS(){
		consultarAudienciaJAVS(idEvento);
	}

	/*
	*Funcion que limpia las cajas de texto
	*antes de llenarlas con los datos de la
	*nueva consulta
	*/
	function limpiaDatosDetalleEvento(){

		$("#tipoAudienciaPJENS").val("");
		$("#numCasoPJENS").val("");
		$("#numExpPJENS").val("");
		$("#audienciaPJENS").val("");
		$("#caracterPJENS").val("");
		$("#fechaAudienciaPJENS").val("");
		$("#horaAudienciaPJENS").val("");
		$("#salaPJENS").val("");
		$("#direccionSalaPJENS").val("");
		$("#ubicacionPJENS").val("");
		$("#juezPJENS").val("");
		$("#audienciaInvPJENS").val("");
		$("#tipoAudienciaInvPJENS").val("");
		$("#numCasoInvPJENS").val("");
		$("#numExpInvPJENS").val("");

	}

//**********************************************************FUNCIONALIDAD DE LA CEJA DETALLES DE AUDIENCIA**********************************************************\

	/*
	*Funcion que consulta el detalle del evento y llena
	*los campos de la TAB Detalle evento
	*/
	function consultaDetalleEvento(idEvento){

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/detalleAudienciasDelDiaPJENS.do',
			data: 'idEvento='+ idEvento,
			async: false,
			dataType: 'xml',
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
				if(parseInt(errorCode)==0){
					
					
    				limpiaDatosDetalleEvento();
    			    tipoAudGlob	= $("#tipoAudienciaPJENS").val($(xml).find('audienciaDTO').find('tipoAudiencia').find('valor').first().text());
    			    $("#numCasoPJENS,#numCasoProgramarAudiencia,#textCaso").val($(xml).find('audienciaDTO').find('expediente').find('casoDTO').find('numeroGeneralCaso').first().text());
    				numeroExpediente = $(xml).find('numeroExpediente').first().text();
    				$("#numExpPJENS,#numExpedienteProgramarAudiencia,#textCausa").val($(xml).find('numeroExpediente').first().text());
    				$("#audienciaPJENS").val($(xml).find('id').first().text());
    				audienciaConsulta=$(xml).find('id').first().text()
    				$("#caracterPJENS").val($(xml).find('caracter').first().text());

    				var fecha= $(xml).find('fechaEvento').text();
    				fechaGlob=fecha;
					formateaFechaHora(fecha);

    				$("#salaPJENS").val($(xml).find('sala').find('nombreSala').first().text());
    				direccionGlob = $("#direccionSalaPJENS").val($(xml).find('sala').find('domicilioSala').first().text());
    				ubicacionGlob = $("#ubicacionPJENS").val($(xml).find('sala').find('ubicacionSala').first().text());
					///////////////////////////////////////JUECES FALTA HACER OTRA CONSULTA///////////////////////////////////////
        					//$("#juezPJENS").val($(xml).find('juez').first().text());
    				$("#audienciaInvPJENS").val($(xml).find('id').first().text());
    				$("#tipoAudienciaInvPJENS").val($(xml).find('tipoAudiencia').find('valor').first().text());
    				$("#numCasoInvPJENS").val($(xml).find('audienciaDTO').find('expediente').find('casoDTO').find('numeroGeneralCaso').first().text());
    				$("#numExpInvPJENS").val($(xml).find('numeroExpediente').first().text());

    				$("#audienciaResPJENS").val($(xml).find('id').first().text());
    				$("#tipoAudienciaResPJENS").val($(xml).find('tipoAudiencia').find('valor').first().text());
    				$("#numCasoResPJENS").val($(xml).find('audienciaDTO').find('expediente').find('casoDTO').find('numeroGeneralCaso').first().text());
    				$("#numExpResPJENS").val($(xml).find('numeroExpediente').first().text());
    				$("#audienciaAccPJENS").val($(xml).find('id').first().text());
    				$("#tipoAudienciaAccPJENS").val($(xml).find('tipoAudiencia').find('valor').first().text());
    				$("#numCasoAccPJENS").val($(xml).find('audienciaDTO').find('expediente').find('casoDTO').find('numeroGeneralCaso').first().text());
    				$("#numExpAccPJENS").val($(xml).find('numeroExpediente').first().text());

    				//Se configuran variables para registrar un amparo
    				idExpediente = $(xml).find('expedienteId').first().text();
    				idNumeroExpediente = $(xml).find('numeroExpedienteId').first().text();

    				//Tab Programar Audiencia
    				//$("#numCasoProgramarAudiencia").val($(xml).find('numeroGeneralCaso').first().text());
    				//$("#numExpedienteProgramarAudiencia").val($(xml).find('numeroExpediente').first().text());
    					$("#fechaLimiteProgramarAudiencia").val($(xml).find('strFechaLimite').first().text());

						tipoAudiencia = $(xml).find('tipoAudiencia').find('idCampo').first().text();
					//LLama a cargar combo de tipos de audiencia para la ceja programar audiencia
    					cargaComboTipoAudiencia(tipoAudiencia);
					
    			}
			}
		});
	}

	/**
	*Funcion que recarga el grid con los imputados de la audiencia
	*/
	function cargaImputadosAudiencia(idEvento){

		jQuery("#gridAudienciasPJENC").jqGrid({
			url:'<%= request.getContextPath()%>/consultarImputadoAudiencia.do?idEvento='+ idEvento +'&tipo=1',
			datatype: "xml",
			colNames:['Nombre','Calidad','Delito','Detenido'],
			colModel:[ 	{name:'nombre',index:'nombre', width:150, align:'center'},
			           	{name:'calidad',index:'calidad', width:130, align:'center'},
			           	{name:'delito',index:'delito', width:155, align:'center'},
			           	{name:'detenido',index:'detenido', width:60, align:'center'}

					],
			pager: jQuery('#pager1'),
			rowNum:10,
			rowList:[10,20,30],
			autowidth: false,
			sortname: 'detalle',
			viewrecords: true,
			sortorder: "desc",
			ondblClickRow: function(rowid) {
				modificarProbResponsable(rowid);
			} ,
			caption:"Imputados en la audiencia actual"
		}).navGrid('#pager1',{edit:false,add:false,del:false});
	}

	/*Funcion que devuelve el total de las Solicitudes de Defensor/*Enable ITByYolo*/
		function cargaSolicitudesAudiencia(idAudiencia){

		jQuery("#gridSolicituesDefensorPJENC").jqGrid({
			url:'<%= request.getContextPath()%>/consultarSolicitudesDefensor.do?audienciaId='+ idAudiencia,
			datatype: "xml",
			colNames:['Nombre','Folio','Fecha'],
			colModel:[ 	{name:'nombre',index:'nombre', width:170, align:'center'},
			           	{name:'calidad',index:'calidad', width:150, align:'center'},
			           	{name:'delito',index:'delito', width:175, align:'center'}

					],
			pager: jQuery('#pager11'),
			rowNum:10,
			rowList:[10,20,30],
			autowidth: false,
			height: 110,
			sortname: 'detalle',
			viewrecords: true,
			sortorder: "desc",
			ondblClickRow: function(rowid) {
				modificarProbResponsable(rowid);
			} ,
			caption:"Solicitudes de Defensor"
		}).navGrid('#pager11',{edit:false,add:false,del:false});
	}
	
	
	/*
	*Funcion que es invocada desde la ventana ingresarProbableResponsableViewPJENS.jsp
	*para refrescar el grid de imputados en la audiencia actual
	*/
	function recargaGridImputados(){
		jQuery("#gridAudienciasPJENC").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarImputadoAudiencia.do?idEvento='+ idEvento +'&tipo=1',datatype: "xml" });
		$("#gridAudienciasPJENC").trigger("reloadGrid");
	}

	//Variable para controlar la ventana de imputado
	var idWindowConsultarImputado = 1;

		//Abre la vantana para consultar el involucrado
		function consultaImputado(idInvolucrado) {

			idWindowConsultarImputado++;

			var idWindow = "iframewindow" + idWindowConsultarImputado;

			var testigo="testigo";

			$.newWindow({id:"iframewindow" + idWindowConsultarImputado, statusBar: true, posx:200,posy:50,width:1050,height:600,title:"Consulta de Imputado", type:"iframe"});
		    $.updateWindowContent("iframewindow" + idWindowConsultarImputado,'<iframe src="<%= request.getContextPath() %>/IngresarTestigoPJENS.do?audienciaId='+idAudiencia+'&numeroExpediente='+numeroExpediente +'&calidad='+testigo+'&idInvolucrado='+idInvolucrado+'&idWindow='+idWindow+'" width="1050" height="600" />');
		}

	var idWindowIngresarProbResponsablePJENS = 1;

	//Abre una nueva ventana de probable responsable
	function modificarProbResponsable(id) {

		idWindowIngresarProbResponsablePJENS++;
		var muestraDetenido = true;
		var elementoNvo="no";

		$.newWindow({id:"iframewindowModificarProbResponsable" + idWindowIngresarProbResponsablePJENS, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Probable Responsable", type:"iframe"});
		$.updateWindowContent("iframewindowModificarProbResponsable" + idWindowIngresarProbResponsablePJENS,'<iframe src="<%= request.getContextPath() %>/IngresarProbResponsablePJENS.do?idProbableResponsable='+id +'&calidadInv=PROBABLE_RESPONSABLE&numeroExpediente='+numeroExpediente +'&detenido='+muestraDetenido+'&elemento='+elementoNvo+'" width="1100" height="530" />');
	}


	/*
	*Funcion que consulta el detalle del evento y llena
	*los campos de la TAB Detalle evento
	*/
	function consultarJuecesDeAudiencia(idAudiencia){

		$.ajax({
			type: 'POST',
			url: '<%=request.getContextPath()%>/consultarJuecesDeAudiencia.do',
			data: 'audienciaId='+ idAudiencia,
			async: false,
			dataType: 'xml',
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
				if(parseInt(errorCode)==0){
					$(xml).find('listaJueces').find('juez').each(function(){
						//Se pone first en el campo de nombre para formar correctamente el nombre del juez
						$('#juezPJENS').append('<option value="' + $(this).find('involucradoId').text() + '">' + $(this).find('nombre').first().text()+" "+$(this).find('apellidoPaterno').first().text()+" "+$(this).find('apellidoMaterno').first().text()+ '</option>');
					});
				}
			}
		});
	}

//**********************************************************FUNCIONALIDAD DE LA CEJA INDIVIDULIZACION*************************************************************\

	//FUNCIONALIDAD PARA AGREGAR FUNCIONARIO


	/**
	*Funcion que abre la ventana modal para introducir un funcionario
	*/
	function agregarFuncionario(){

		habilitarCampos();
		cargaComboFuncionarios();
		$("#divIngresarFuncionario").dialog("open");
	  	$("#divIngresarFuncionario").dialog({ autoOpen: true,
		modal: true,
	  	title: 'Agregar funcionario a la audiencia',
	  	dialogClass: 'alert',
	  	position: [400,220],
	  	width: 450,
	  	height: 300,
	  	maxWidth: 450,
		maxHeight: 300,
		minWidth: 450,
		minHeight: 300,
	  	buttons:{"Aceptar":function() {
	  			var selected = $("#cbxFuncionarioPJENS option:selected").val();
		  		if(selected == 0){
		  			if(validarDatosFuncionario() == true){
			  			guardarFuncionario();
			  			$(this).dialog("close");
				  	}
			  	}
		  		else{
		  			guardarFuncionario();
		  			$(this).dialog("close");
			  	}
		  	},
			"Cancelar" : function() {
				$(this).dialog("close");
			}
		  }
		});
	}

	/*
	*Funcion que dispara el Action para consultar Funcionario por tipo de especialidad
	*/
	function cargaComboFuncionarios(){

		limpiaComboFuncionarios();

		var tipoEspecialidad;

		if(puestoFuncionario == "amp"){
			tipoEspecialidad=<%=TipoEspecialidad.MINISTERIO_PUBLICO.getValorId()%>;
		}
		if(puestoFuncionario == "defensor"){
			tipoEspecialidad=<%=TipoEspecialidad.DEFENSOR.getValorId()%>;
		}
		if(puestoFuncionario == "perito"){
			tipoEspecialidad=<%=TipoEspecialidad.PERICIAL.getValorId()%>;
		}
		if(puestoFuncionario == "policia"){
			tipoEspecialidad=<%=TipoEspecialidad.POLICIA.getValorId()%>;
		}

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarCatalogoFuncionariosPorTipoEspecialidad.do',
			data:'tipoEspecialidad='+tipoEspecialidad ,
			dataType: 'xml',
			async: false,
			success: function(xml){

				$(xml).find('listaFuncionarios').find('funcionario').each(function(){
					$('#cbxFuncionarioPJENS').append('<option value="' + $(this).find('claveFuncionario').text() + '">'+ $(this).find('nombreFuncionario').text() + ' '+$(this).find('apellidoPaternoFuncionario').text() + ' '+$(this).find('apellidoMaternoFuncionario').text() +'</option>');
				});
			}
		});
	}


	function habilitaCampos(){

		var selected = $("#cbxFuncionarioPJENS option:selected").val();

		limpiaVentanaIngresarFuncionario();
		if(selected == 0){
			$('#nombreFuncionarioPJENS').attr('disabled', false);
			$('#apPatFuncionarioPJENS').attr('disabled', false);
			$('#apMatFuncionarioPJENS').attr('disabled', false);
		}
		else{
			$('#nombreFuncionarioPJENS').attr('disabled', true);
			$('#apPatFuncionarioPJENS').attr('disabled', true);
			$('#apMatFuncionarioPJENS').attr('disabled', true);

		}
	}


	/*
	*Valida que los datos del funcionario esten completos
	*/
	function validarDatosFuncionario(){

		if($('#nombreFuncionarioPJENS').val().trim() != "" && $('#apPatFuncionarioPJENS').val().trim() != ""){
			return true;
		}
		else{
			alertDinamico("Ingrese el nombre completo del funcionario");
			return false;
		}
	}

	/*
	*Funcion refresca grids
	*/
	function recargaGrids(){

		if(puestoFuncionario == "amp"){
			tipoConsulta=1;
			jQuery("#gridFiscal").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridFiscal").trigger("reloadGrid");
		}
		if(puestoFuncionario == "defensor"){
			tipoConsulta=2;
			jQuery("#gridDefensor").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridDefensor").trigger("reloadGrid");
		}
		if(puestoFuncionario == "perito"){
			tipoConsulta=4;
			jQuery("#gridPerito").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridPerito").trigger("reloadGrid");
		}
		if(puestoFuncionario == "policia"){
			tipoConsulta=5;
			jQuery("#gridPolicia").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridPolicia").trigger("reloadGrid");
		}
	}

	/*
	*Funcion que agrega el enumm para la especialidad del funcionario
	*/
	function guardarFuncionario(){

		var puesto;
		var tipoEspecialidad;

		if(puestoFuncionario == "amp"){
			puesto=<%=Puestos.FISCAL.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.MINISTERIO_PUBLICO.getValorId()%>;
		}
		if(puestoFuncionario == "defensor"){
			puesto=<%=Puestos.ABOGADO_DEFENSOR.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.DEFENSOR.getValorId()%>;
		}
		if(puestoFuncionario == "perito"){
			puesto=<%=Puestos.PERITO.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.PERICIAL.getValorId()%>;
		}
		if(puestoFuncionario == "policia"){
			puesto=<%=Puestos.POLICIA_MINISTERIAL.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.POLICIA.getValorId()%>;
		}

		var parametrosFunc='';

		parametrosFunc += 'nombreFunc='+ $('#nombreFuncionarioPJENS').val().trim();
		parametrosFunc += '&apPatFunc=' + $('#apPatFuncionarioPJENS').val().trim();
		parametrosFunc += '&apMatFunc=' + $('#apMatFuncionarioPJENS').val().trim();
		parametrosFunc += '&puesto=' + puesto;
		parametrosFunc += '&tipoEspecialidad=' + tipoEspecialidad;
		parametrosFunc += '&idAudiencia=' + idAudiencia;
		parametrosFunc += '&claveFuncionario=' + $("#cbxFuncionarioPJENS option:selected").val();

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/guardarFuncionarioPorNombreYPuesto.do',
			data: parametrosFunc,
			dataType: 'xml',
			async: false,
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
				if(parseInt(errorCode)==0){
					alertDinamico("Funcionario guardado con �xito");
					recargaGrids();
					limpiaVentanaIngresarFuncionario();
					limpiaComboFuncionarios();
					habilitaCampos();
    			}
				else{
					habilitaCampos();
					limpiaVentanaIngresarFuncionario();
					//Mostrar mensaje de error
				}
			}
		});
	}



	/*
	*Funcion para eliminar la relacion entre un funcionario y la audiencia
	*/
	function eliminarFuncionarioAudiencia(claveFuncionario){

		if (claveFuncionario){

			var parametrosEliminar='';

			parametrosEliminar += 'claveFuncionario='+ claveFuncionario;
			parametrosEliminar += '&idAudiencia=' + idAudiencia;

			$.ajax({
				type: 'POST',
				url: '<%= request.getContextPath()%>/eliminarFuncionarioAudiencia.do',
				data: parametrosEliminar,
				dataType: 'xml',
				async: false,
				success: function(xml){

					var errorCode=$(xml).find('response').find('code').text();

					if(parseInt(errorCode)==0){

						respuesta = $(xml).find('String').text();

						if(respuesta == "ok"){
							alertDinamico("Funcionario eliminado con �xito");
							recargaGrids();
						}else{
							alertDinamico("El funcionario no pudo ser eliminado");
						}
	    			}
					else{
						//Error
					}
				}
			});
		}
		else{
			alertDinamico("Seleccione un funcionario");
		}
	}

	/*
	*Funcion que guarda la Asistencia del funcionario, al momento de dar clic en el checkbox
	* se crea desde ConsultarEventosPJENSAction en consultarInvolucradosAudienciaIndividualizacion
	* y sirve como un escuchador de eventos
	*/
	function guardarAsistenciaFuncionario(involucradoID){

		var parametros='';

		parametros += 'claveFuncionario=' + involucradoID;
		parametros += '&idAudiencia=' + idAudiencia;
		parametros += '&esTitular='+ ($('#chkTit_'+involucradoID).is(':checked')?"true":"false");
		parametros += '&presente=' + ($('#chkPre_'+involucradoID).is(':checked')?"true":"false");

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/registrarAsistenciaFuncionario.do',
			data: parametros,
			dataType: 'xml',
			async: false,
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
			}
		});
	}

	/*
	*Funcion que guarda la Asistencia del involucrado en audiencia, al momento de dar clic en el checkbox
	* se crea desde ConsultarEventosPJENSAction en consultarInvolucradosAudienciaIndividualizacion
	* y sirve como un escuchador de eventos
	*/
	function guardarAsistenciaInvolucradoAudiencia(involucradoID){

		var parametros='';

		parametros += 'claveFuncionario=' + involucradoID;
		parametros += '&idAudiencia=' + idAudiencia;
		parametros += '&presente=' + ($('#chkPre_'+involucradoID).is(':checked')?"true":"false");

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/registrarAsistenciaInvolucradoAudiencia.do',
			data: parametros,
			dataType: 'xml',
			async: false,
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
			}
		});
	}

	//Crea una nueva ventana de testigo
	function creaNuevoTestigo(idInvolucrado) {

		idWindowIngresarTestigo++;

		var idWindow = "iframewindowIngresarTestigo" + idWindowIngresarTestigo;

		testigo="testigo";
		$.newWindow({id:"iframewindowIngresarTestigo" + idWindowIngresarTestigo, statusBar: true, posx:200,posy:50,width:1050,height:600,title:"Ingresar Testigo", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarTestigo" + idWindowIngresarTestigo,'<iframe src="<%= request.getContextPath() %>/IngresarTestigoPJENS.do?audienciaId='+idAudiencia+'&numeroExpediente='+numeroExpediente +'&calidad='+testigo+'&idInvolucrado='+idInvolucrado+'&idWindow='+idWindow+'" width="1050" height="600" />');

	}

	//variable para controlar el id de la ventana
	var idWindowIngresarTestigoAudienciaSiguiente= 1;

	//Crea una nueva ventana de testigo para la siguiente audiencia
	function creaNuevoTestigoAudienciaSiguiente(idInvolucrado) {

		idWindowIngresarTestigoAudienciaSiguiente++;

		var idWindow = "iframewindowIngresarTestigo" + idWindowIngresarTestigoAudienciaSiguiente;

		testigo="testigo";
		$.newWindow({id:"iframewindowIngresarTestigo" + idWindowIngresarTestigoAudienciaSiguiente, statusBar: true, posx:200,posy:50,width:1050,height:600,title:"Ingresar Testigo", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarTestigo" + idWindowIngresarTestigoAudienciaSiguiente,'<iframe src="<%= request.getContextPath() %>/IngresarTestigoPJENS.do?audienciaId='+idAudienciaSiguiente+'&numeroExpediente='+numeroExpediente +'&calidad='+testigo+'&idInvolucrado='+idInvolucrado+'&idWindow='+idWindow+'&esSiguiente=true" width="1050" height="600" />');
	}

	//Cierra la ventana que lo invoque de acuerdo a u identificador
	function cerrarVentanaIngresarTestigo(idWindow){

		$.closeWindow(idWindow);
	}

	/*
	*Funcion que limpia los datos de la ventana modal
	*ingresar funcionario a audiencia
	*/
	function limpiaVentanaIngresarFuncionario(){

		$('#nombreFuncionarioPJENS').val("");
		$('#apPatFuncionarioPJENS').val("");
		$('#apMatFuncionarioPJENS').val("");
	}

	/*
	*Funcion que limpia el combo de funcionarios
	*/
	function limpiaComboFuncionarios(){

		$('#cbxFuncionarioPJENS').empty();
		$('#cbxFuncionarioPJENS').append('<option value="0">-Seleccione-</option>');
		//Por default seleccione
	}

	/*
	*Funcion que habilita los campos de captura
	*/
	function habilitarCampos(){

		$('#nombreFuncionarioPJENS').attr('disabled', false);
		$('#apPatFuncionarioPJENS').attr('disabled', false);
		$('#apMatFuncionarioPJENS').attr('disabled', false);
	}
	//TERMINA FUNCIONALIDAD PARA AGREGAR FUNCIONARIO



	var banderaCargaGridVictima = true;
	/*
	*Funcion que carga el grid de victimas
	*/
	function cargaGridVictima(){

		if( banderaCargaGridVictima == true){

			jQuery("#gridVictima").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+TIPO_CONSULTA_VICTIMA,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
							{name:'APaterno',index:'APaterno', width:180},
							{name:'AMaterno',index:'AMaterno', width:180},
							{name:'Presente',index:'Presente', width:50},
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridVictima'),
					sortname: 'Nombre',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					toolbar: [true,"top"],
					caption:"V�ctima",
					ondblClickRow: function(rowid) {
						consultarVictima(rowid);
					}
			}).navGrid('#paginadorGridVictima',{edit:false,add:false,del:false});

			$("#t_gridVictima").append("<input type='button' class='btn_Generico' value='Agregar V&iacute;ctima' style='height:20px;font-size:-3'/>");
			$("input","#t_gridVictima").click(function(){
				creaNuevaVictima();
			});

			banderaCargaGridVictima= false;
		}
		else{
			jQuery("#gridVictima").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+TIPO_CONSULTA_VICTIMA , datatype: "xml" });
			$("#gridVictima").trigger("reloadGrid");
		}
	}

	var banderaCargaGridVictimaOrg = true;
	/*
	*Funcion que carga el grid de victimas
	*/
	function cargaGridVictimaOrg(){

		if( banderaCargaGridVictimaOrg == true){

			jQuery("#gridVictimaOrg").jqGrid({

				url:'<%= request.getContextPath() %>/consultarOrganizacionesDeAudiencia.do?audienciaId='+idAudiencia,
				datatype: "xml",
				colNames:['Nombre organizaci&oacute;n','Nombre corto', 'Tipo de organizaci&oacute;n'],
				colModel:[ 	{name:'nombreOrganizacion',index:'nombreOrganizacion', width:230},
							{name:'nombreCorto',index:'nombreCorto', width:180},
							{name:'tipoOrganizacion',index:'tipoOrganizacion', width:180}
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridVictimaOrg'),
					sortname: 'nombreOrganizacion',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					caption:"V�ctima Persona Moral",
					ondblClickRow: function(rowid) {
						consultarVictimaOrg(rowid);
					}
			}).navGrid('#paginadorGridVictimaOrg',{edit:false,add:false,del:false});

			banderaCargaGridVictimaOrg= false;
		}
		else{
			jQuery("#gridVictima").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarOrganizacionesDeAudiencia.do?audienciaId='+idAudiencia});
			$("#gridVictima").trigger("reloadGrid");
		}
	}

	var idWindowIngresarVictima = 1;

	//Abre una nueva ventana de crear una nueva victima
	function creaNuevaVictima() {
		idWindowIngresarVictima++;
		var elementoNuevo="si";
		$.newWindow({id:"iframewindowIngresarVictima" + idWindowIngresarVictima, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar V�ctima", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarVictima" + idWindowIngresarVictima,'<iframe src="<%= request.getContextPath() %>/IngresarVictima.do?numeroExpediente='+numeroExpediente +'&audienciaId='+idAudiencia+'&elemento='+elementoNuevo+'" width="1100" height="530" />');
	}

	var idWindowConsultarVictima = 1;

	//Abre una nueva ventana para consultar una v�ctima
	function consultarVictima(idInvolucrado){
		idWindowConsultarVictima++;
		$.newWindow({id:"iframewindowConsultarVictima" + idWindowConsultarVictima, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Consultar V&iacute;ctima", type:"iframe"});
		$.updateWindowContent("iframewindowConsultarVictima" + idWindowConsultarVictima,'<iframe src="<%= request.getContextPath() %>/ConsultarIndividuo.do?numeroExpediente='+numeroExpediente+'&idVictima='+idInvolucrado+'&idCalidad=VICTIMA" width="1100" height="530" />');
	}

	//Abre una nueva ventana para consultar una v�ctima
	function consultarVictimaOrg(idOrganizacion){
		idWindowConsultarVictima++;
		$.newWindow({id:"iframewindowConsultarVictima" + idWindowConsultarVictima, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Consultar V&iacute;ctima", type:"iframe"});
		$.updateWindowContent("iframewindowConsultarVictima" + idWindowConsultarVictima,'<iframe src="<%= request.getContextPath() %>/ConsultarIndividuo.do?numeroExpediente='+numeroExpediente+'&idOrganizacion='+idOrganizacion+'&idCalidad=VICTIMA" width="1100" height="530" />');
	}

	/*
	*Estas funciones son usadas en ingresarVictimaView.jsp con el proposito de modificar esa JSP
	*asi que solo se agregan aqui para refrescar el grid en el caso de que se agregue una victima
	*o se modifique
	*/
	function cargaVictima(){
		cargaGridVictima();
		cargaGridVictima1();
	}

	function refresca(){
		cargaGridVictima();
		cargaGridDenunciante();
		cargaGridVictima1();
		cargaGridDenunciante1();
	}


	var banderaCargaGridDenunciante = true;
	/*
	*Funcion que carga el grid de denunciantes
	*/
	function cargaGridDenunciante(){

		if( banderaCargaGridDenunciante == true){

			jQuery("#gridDenunciante").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+TIPO_CONSULTA_DENUNCIANTE,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
							{name:'APaterno',index:'APaterno', width:180},
							{name:'AMaterno',index:'AMaterno', width:180},
							{name:'Presente',index:'Presente', width:50},
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridDenunciante'),
					sortname: 'Nombre',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					toolbar: [true,"top"],
					caption:"Denunciante",
					ondblClickRow: function(rowid) {

						consultarDenunciante(rowid);
					}
			}).navGrid('#paginadorGridDenunciante',{edit:false,add:false,del:false});

			$("#t_gridDenunciante").append("<input type='button' class='btn_Generico' value='Agregar Denunciante' style='height:20px;font-size:-3'/>");
			$("input","#t_gridDenunciante").click(function(){
				crearDenunciante();
			});

			banderaCargaGridDenunciante = false;
		}
		else{
			jQuery("#gridDenunciante").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+TIPO_CONSULTA_DENUNCIANTE, datatype: "xml" });
			$("#gridDenunciante").trigger("reloadGrid");
		}
	}


	var idWindowIngresarDenunciante = 1;

	//Abre una nueva ventana de Denunciante
	function crearDenunciante(){
		idWindowIngresarDenunciante++;
		elementoNuevo = "si";
		$.newWindow({id:"iframewindowIngresarDenunciante" + idWindowIngresarDenunciante, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar Denunciante", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarDenunciante" + idWindowIngresarDenunciante,'<iframe src="<%= request.getContextPath() %>/IngresarDenunciante.do?numeroExpediente='+numeroExpediente +'&audienciaId='+idAudiencia+'&elemento='+elementoNuevo+'&calidadInv=DENUNCIANTE" width="1100" height="530" />');
	}

	var idWindowConsultarDenunciante = 1;

	//Abre una nueva ventana de Denunciante
	function consultarDenunciante(id){
		idWindowConsultarDenunciante++;
		$.newWindow({id:"iframewindowIngresarDenunciante" + idWindowConsultarDenunciante, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar Denunciante", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarDenunciante" + idWindowConsultarDenunciante,'<iframe src="<%= request.getContextPath() %>/IngresarDenunciante.do?idDenunciante='+id +'&numeroExpediente='+numeroExpediente +'&calidadInv=DENUNCIANTE" width="1100" height="530" />');
	}

	function cargaVictimaDenunciante(){
		cargaGridVictima();
		cargaGridDenunciante();
		cargaGridVictima1();
		cargaGridDenunciante1();
	}

	function cargaDenunciante(){
		cargaGridDenunciante();
		cargaGridDenunciante1();
	}


	/*
	*Funcion que carga el grid de ficales
	*/
	function cargaGridFiscal(){

		tipoConsulta=1;


		jQuery("#gridFiscal").jqGrid({

			url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Titular','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
						{name:'APaterno',index:'APaterno', width:180},
						{name:'AMaterno',index:'AMaterno', width:180},
						{name:'Titular',index:'Titular', width:50,align:'center'},
						{name:'Presente',index:'Presente', width:60,align:'center'}
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridFiscal'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				loadComplete: function(){
					primeraFiscal="false";
				},
				caption:"Fiscal",
				ondblClickRow: function(rowid) {
					$("#butNotificacionFiscal").attr("disable",false);
				}
		}).navGrid('#paginadorGridFiscal',{edit:false,add:false,del:false});

		//Button agregar amp
		$("#t_gridFiscal").append("<input type='button' class='btn_Generico' id='butAgreAmp' value='Agregar Amp' style='height:20px;font-size:-3'/>");
		//Button eliminar amp
		$("#t_gridFiscal").append("<input type='button' class='btn_Generico' id='butElimAmp' value='Eliminar Amp' style='height:20px;font-size:-3'/>");

		$("#butAgreAmp","#t_gridFiscal").click(function(){
			puestoFuncionario="amp";
			agregarFuncionario();
		});

		$("#butElimAmp","#t_gridFiscal").click(function(){
			puestoFuncionario="amp";
			var rowid = jQuery("#gridFiscal").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudiencia(rowid);
		});
	}


	/*
	*Funcion que carga el grid de defensores
	*/
	function cargaGridDefensor(){

		tipoConsulta=2;

		jQuery("#gridDefensor").jqGrid({

			url:'<%= request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Titular','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
						{name:'APaterno',index:'APaterno', width:180},
						{name:'AMaterno',index:'AMaterno', width:180},
						{name:'Titular',index:'Titular', width:50,align:'center'},
						{name:'Presente',index:'Presente', width:60,align:'center'}
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridDefensor'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				caption:"Defensor"
		}).navGrid('#paginadorGridDefensor',{edit:false,add:false,del:false});

		$("#t_gridDefensor").append("<input type='button' class='btn_Generico' id='butADefensor' value='Agregar Defensor' style='height:20px;font-size:-3'/>");

		$("#t_gridDefensor").append("<input type='button' class='btn_Generico' id='butSDefensor' value='Solicitar Defensor' style='height:20px;font-size:-3'/>");

		$("#t_gridDefensor").append("<input type='button' class='btn_Generico' id='butElimDef' value='Eliminar Defensor' style='height:20px;font-size:-3'/>");


		$("#butADefensor","#t_gridDefensor").click(function(){
			puestoFuncionario="defensor";
			agregarFuncionario();
		});

		$("#butSDefensor","#t_gridDefensor").click(function(){
			solicitarDefensor();
		});

		$("#butElimDef","#t_gridDefensor").click(function(){
			puestoFuncionario="defensor";
			var rowid = jQuery("#gridDefensor").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudiencia(rowid);
		});
	}





	var banderaCargaGridTestigo = true;
	/*
	*Funcion que carga el grid de testigos
	*/
	function cargaGridTestigo(){

		tipoConsulta=3;

		if( banderaCargaGridTestigo == true){

			jQuery("#gridTestigo").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
							{name:'APaterno',index:'APaterno', width:180},
							{name:'AMaterno',index:'AMaterno', width:180},
							{name:'Presente',index:'Presente', width:50},
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridTestigo'),
					sortname: 'Nombre',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					toolbar: [true,"top"],
					caption:"Testigo",
					ondblClickRow: function(rowid) {

						creaNuevoTestigo(rowid);
					}
			}).navGrid('#paginadorGridTestigo',{edit:false,add:false,del:false});

			$("#t_gridTestigo").append("<input type='button' class='btn_Generico' value='Agregar Testigo' style='height:20px;font-size:-3'/>");
			$("input","#t_gridTestigo").click(function(){
				creaNuevoTestigo(null);
			});

			banderaCargaGridTestigo= false;
		}
		else{
			jQuery("#gridTestigo").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta , datatype: "xml" });
			$("#gridTestigo").trigger("reloadGrid");
		}
	}


	/*
	*Funcion que carga el grid de peritos
	*/
	function cargaGridPerito(){

		tipoConsulta=4;

		jQuery("#gridPerito").jqGrid({

			url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Parte','Especialidad','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
						{name:'APaterno',index:'APaterno', width:180},
						{name:'AMaterno',index:'AMaterno', width:180},
						{name:'Especialidad',index:'Especialidad', width:100},
						{name:'Parte',index:'Parte', width:100},
						{name:'Presente',index:'Presente', width:50},
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridPerito'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				caption:"Perito"
		}).navGrid('#paginadorGridPerito',{edit:false,add:false,del:false});

		$("#t_gridPerito").append("<input type='button' class='btn_Generico' id='butAgregarPer' value='Agregar Perito' style='height:20px;font-size:-3'/>");

		$("#t_gridPerito").append("<input type='button' class='btn_Generico' id='butElimPer' value='Eliminar Perito' style='height:20px;font-size:-3'/>");

		$("#butAgregarPer","#t_gridPerito").click(function(){
			puestoFuncionario="perito";
			agregarFuncionario();
		});

		$("#butElimPer","#t_gridPerito").click(function(){
			puestoFuncionario="perito";
			var rowid = jQuery("#gridPerito").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudiencia(rowid);
		});
	}


	/*
	*Funcion que carga el grid de elemento de policia ministerial
	*/
	function cargaGridPolicia(){

		tipoConsulta=5;

		jQuery("#gridPolicia").jqGrid({

			url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Parte','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180},
						{name:'APaterno',index:'APaterno', width:180},
						{name:'AMaterno',index:'AMaterno', width:180},
						{name:'Parte',index:'Parte', width:100},
						{name:'Presente',index:'Presente', width:50},
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridPolicia'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				caption:"Elemento de la polic�a ministerial"
		}).navGrid('#paginadorGridPolicia',{edit:false,add:false,del:false});

		$("#t_gridPolicia").append("<input type='button' class='btn_Generico' id='butAgrePoli' value='Agregar Policia Ministerial' style='height:20px;font-size:-3'/>");

		//Button eliminar policia ministerial
		$("#t_gridPolicia").append("<input type='button' class='btn_Generico' id='butElimPoli' value='Eliminar Policia Ministerial' style='height:20px;font-size:-3'/>");

		$("#butAgrePoli","#t_gridPolicia").click(function(){
			puestoFuncionario="policia";
			agregarFuncionario();
		});

		$("#butElimPoli","#t_gridPolicia").click(function(){
			puestoFuncionario="policia";
			var rowid = jQuery("#gridPolicia").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudiencia(rowid);
		});
	}


	/*
	*Funcion abre una ventana modal para solicitar un abogado defensor
	*/
	function solicitarDefensor(){

		//Carga el grid con los involucrados
		jQuery("#ListaImputados").jqGrid({
			url:'<%= request.getContextPath()%>/consultarImputadoAudiencia.do?idEvento='+ idAudiencia +'&tipo=0',
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno','Apellido Materno'],
			colModel:[ 	{name:'nombre',index:'nombre', width:70, align: "center"},
			           	{name:'apaterno',index:'apaterno', width:120, align: "center"},
			           	{name:'amaterno',index:'amaterno', width:120, align: "center"}

					],
			pager: jQuery('#paginadorListaImputados'),
			rowNum:10,
			rowList:[10,20,30],
			width: 320,
			height:80,
			sortname: 'nombre',
			viewrecords: true,
			sortorder: "desc",
			multiselect: true,
			caption: "Lista de Imputados"

		}).navGrid('#paginadorListaImputados',{edit:false,add:false,del:false});

		//Abre la ventana modal
		$("#divSolicitarDefensor").dialog("open");
	  	$("#divSolicitarDefensor").dialog({ autoOpen: true,
			modal: true,
		  	title: 'Solicitar Defensor',
		  	dialogClass: 'alert',
		  	position: [312,40],
		  	width: 435,
		  	height: 300,
		  	maxWidth: 1000,
		  	buttons:{"Enviar":function() {
	   		 		var s;
	   		  		s = jQuery("#ListaImputados").jqGrid('getGridParam','selarrrow');
					var idEventoGlobal=idAudiencia;

			   		$.ajax({
						type: 'POST',
						url: '<%= request.getContextPath()%>/enviarSolicitudDefensor.do?idImputado='+s+'&idAudiencia='+idEventoGlobal+'',
						async: false,
						dataType: 'xml',
						success: function(xml){
							alertDinamico("Solicitud enviada");
						}
					});
			   		$(this).dialog("close");
		  		},
		  		"Cancelar":function() {
			  		customConfirm("�Realmente desea salir de la solicitud del abogado defensor sin enviar la solicitud?", "", cancelarEnvioAudiencia);
		  		}
		  	}
		});
	}

	function cancelarEnvioAudiencia(){
		$("#divSolicitarDefensor").dialog("close");
	}


//*************************************************************FUCIONALIDAD PARA LA CEJA PRUEBAS******************************************************************/

	//////////////////////FUNCIONALIDAD PARA LA CEJA DATOS DE PRUEBA

	var banderaDatosPrueba = true;
	/**
	*Funcion que carga el grid datos de Prueba
	*/
	function cargaGridDatosPrueba(){

		if(banderaDatosPrueba == true){
			jQuery("#gridDatosDePruebaPJENS").jqGrid({
				url:'<%=request.getContextPath()%>/consultarDatosDePruebaPorFiltro.do?audienciaId='+audienciaId+'&numeroExpediente='+numeroExpediente+'',
				datatype: "xml",
				colNames:['Nombre del Dato','N�mero de Identificaci�n', 'Reg. de Cadena de Custodia','Registrado','Aceptado','Desechado'],
				colModel:[
				           	{name:'nombreDato',index:'nombreDato', width:100, align:'left'},
				           	{name:'numIdentificacion',index:'numIdentificacion', width:80, align:'left'},
				        	{name:'rcc',index:'rcc', width:100, align:'left'},
				           	{name:'registrado',index:'registrado', width:50, align:'center'},
				           	{name:'aceptado',index:'aceptado', width:50, align:'center'},
				           	{name:'rechazado',index:'rechazado', width:50, align:'center'},
						],
				pager: jQuery('#pagerGridDatosDePruebaPJENS'),
				rowNum:10,
				autoWidth:false,
				width:800,
				//autoheight:true,
				rowList:[10,20,30],
				sortname: 'NombreDato',
				viewrecords: true,
				sortorder: "desc",
				caption:"Datos de Prueba",
				toolbar: [true,"top"],
				ondblClickRow: function(rowid) {
					consultarDatoDePrueba(rowid);
				}
			}).navGrid('#pagerGridDatosDePruebaPJENS',{edit:false,add:false,del:false});
			$("#gview_gridDatosDePruebaPJENS .ui-jqgrid-bdiv").css('height', '200px');

			banderaDatosPrueba=false;

			//$("#t_gridDatosDePruebaPJENS").append("<input type='button' id='btnAgregarDatoPrueba' class='btn_grande' value='Agregar' style='height:20px;width:60px;font-size:-3'/>"+" "+"<input type='button' id='btnRelacionarDatoPrueba' class='btn_grande' value='Relacionar' style='height:20px;width:70px;font-size:-3'/>"+" "+"<input type='button' id='btnAsociarDatoPrueba' class='btn_grande' value='Asociar' style='height:20px;width:70px;font-size:-3'/>");
			$("#t_gridDatosDePruebaPJENS").append("<input type='button' id='btnAgregarDatoPrueba' class='btn_Generico' value='Agregar' style='height:20px;width:60px;font-size:-3'/>"+" "+"<input type='button' id='btnRelacionarDatoPrueba' class='btn_Generico' value='Relacionar' style='height:20px;width:70px;font-size:-3'/>");

			$("#btnAgregarDatoPrueba","#t_gridDatosDePruebaPJENS").click(function(){
				agregarDatoDePrueba();
			});

			$("#btnRelacionarDatoPrueba","#t_gridDatosDePruebaPJENS").click(function(){
				var rowid = jQuery("#gridDatosDePruebaPJENS").jqGrid('getGridParam','selrow');
				if(rowid){
					var renglon = jQuery("#gridDatosDePruebaPJENS").jqGrid('getRowData',rowid);
					//verifica si la sub string checked se encuentra en la cadena input,
					//de NO ser asi devuelve -1
					if(renglon.aceptado.indexOf("checked") != -1){

						relacionarMediosDePrueba(rowid);
					}
					else{
						alertDinamico("El dato de prueba debe ser aceptado para \n relacionarlo con un medio de prueba");
					}
				}
				else{
					alertDinamico("Seleccione un dato de prueba a relacionar");
				}
			});

			//Originalmente la funcionalidad de asociar paria de este grid
			$("#btnAsociarDatoPrueba","#t_gridDatosDePruebaPJENS").click(function(){
				var rowid = jQuery("#gridDatosDePruebaPJENS").jqGrid('getGridParam','selrow');
				if(rowid){
					var renglon = jQuery("#gridDatosDePruebaPJENS").jqGrid('getRowData',rowid);
					//verifica si la sub string checked se encuentra en la cadena input,
					//de NO ser asi devuelve -1
					if(renglon.aceptado.indexOf("checked") != -1){
						asociarDatoPrueba(rowid);
					}
					else{
						alertDinamico("El dato de prueba debe ser aceptado para \n asociarlo con un imputado");
					}
				}
				else{
					alertDinamico("Seleccione un dato de prueba a asociar");
				}
			});
		}
		else{
			jQuery("#gridDatosDePruebaPJENS").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarDatosDePruebaPorFiltro.do?audienciaId='+audienciaId+'&numeroExpediente='+numeroExpediente+'',datatype: "xml" });
			$("#gridDatosDePruebaPJENS").trigger("reloadGrid");
		}
	}


	/*
	*Funcion para cambiar el estado del dato de prueba
	*/
	function rechazarDatoPrueba(datoPruebaId){
		$.ajax({
	   		type: 'POST',
	   		url: '<%= request.getContextPath()%>/actualizarEstadoDatoPrueba.do?esAceptado=false&numeroExpediente='+numeroExpediente+'',
	   		data:'datoPruebaId='+datoPruebaId,
	   		dataType: 'xml',
	   		async: false,
	   		success: function(xml){
	   			cargaGridDatosPrueba();
	   			cargaGridPrueba();
	   			alertDinamico("El dato de prueba ha sido rechazado");
	   		}
		});
	}

	/*
	*Funcion para cambiar el estado del dato de prueba
	*/
	function aceptarDatoPrueba(datoPruebaId){
		$.ajax({
    		type: 'POST',
    		url: '<%= request.getContextPath()%>/actualizarEstadoDatoPrueba.do?esAceptado=true&numeroExpediente='+numeroExpediente+'',
    		data:'datoPruebaId='+datoPruebaId,
    		dataType: 'xml',
    		async: false,
    		success: function(xml){
    			alertDinamico("El dato de prueba ha sido aceptado");
    			cargaGridDatosPrueba();
    			cargaGridPrueba();
    		}
		});
	}



	//Funcion usada para asignarle id a la ventana de consultar datos de prueba
	var consultarDatoPruebaWindow = 1;
	/*
	*Funcion para consultar datos de prueba vs medios de prueba
	*/
	function consultarDatoDePrueba(idDatoPrueba){
		consultarDatoPruebaWindow++;
		$.newWindow({id:"iframewindowConsultarDatoPrueba"+consultarDatoPruebaWindow, statusBar: true, posx:80,posy:60,width:1240,height:420,title:"Consultar Dato de Prueba", type:"iframe"});
		<%-- enable It agregando parametro audiencia para asignar expediente id en el action y poder ver los medios de prueba asociados a la prueba
    	$.updateWindowContent("iframewindowConsultarDatoPrueba"+consultarDatoPruebaWindow,'<iframe src="<%= request.getContextPath() %>/consultarDetalleDatoPruebaPJENS.do?idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'" width="1240" height="420" />'); --%>
    	$.updateWindowContent("iframewindowConsultarDatoPrueba"+consultarDatoPruebaWindow,'<iframe src="<%= request.getContextPath() %>/consultarDetalleDatoPruebaPJENS.do?audienciaId='+idEvento+'&idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'" width="1240" height="420" />');
	}



	/*
	*Funcion que abre la modal para relacionar los datos de prueba
	*con los medios de prueba
	*/
	function relacionarMediosDePrueba(idDatoPrueba){

		cargaGridMediosPrueba(idDatoPrueba);
		$("#divRelacionarMediosDePruebaPJENS").dialog("open");
		$("#divRelacionarMediosDePruebaPJENS").dialog({ autoOpen: true, modal: true,
		title: 'Relacionar medios de prueba',
		dialogClass: 'alert', position: [350,50],
		width: 800, height:480, maxWidth: 800, maxHeight:550,
		buttons:{
			"Relacionar":function() {

				var iDsMediosPrueba="";
				iDsMediosPrueba = jQuery("#gridRelacionarMediosDePruebaPJENS").jqGrid('getGridParam','selarrrow');
				guardarRelacionMediosDePruebaVsDatoPrueba(idDatoPrueba,iDsMediosPrueba);
			   	$(this).dialog("close");
			},
			"Cancelar":function() {

				customConfirm("�Realmente desea salir?", "", cancelarRelacionarMediosDePrueba);
			}
		}
		});
	}

	function cancelarRelacionarMediosDePrueba(){
  		$("#divRelacionarMediosDePruebaPJENS").dialog("close");
	}



	/**
	*Funcion que guarda la relacion entre los medios de prueba
	*recibe un arreglo con los ids de medios de prueba y el id del dato de prueba
	*con el que se relacionaran
	*/
	function guardarRelacionMediosDePruebaVsDatoPrueba(idDatoPrueba,iDsMediosPrueba){

		$.ajax({
    		type: 'POST',
    		url: '<%= request.getContextPath()%>/relacionarMedioPruebaConDatoPrueba.do?iDsMediosPrueba='+iDsMediosPrueba+'&idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'',
    		data:'',
    		dataType:'xml',
    		async:false,
    		success: function(xml){
	   			if(parseInt($(xml).find('code').text())==0)
	    		  {
	   				alertDinamico("La relaci�n ha sido guardada");
					//Limpiar los ids seleccionados
	   	    	}
	  			else{
	  				alertDinamico("Ocurri� un error durante la relaci�n");
	      		}
    		}
		});
	}


	//Variable para controlar si se carga por primera vez el grid
	var banderaRelacionarMediosPrueba = true;

	/**
	*Funcion que carga el grid medios de Prueba
	*/
	function cargaGridMediosPrueba(idDatoPrueba){

		if(banderaRelacionarMediosPrueba == true){

			jQuery("#gridRelacionarMediosDePruebaPJENS").jqGrid({
				url:'<%=request.getContextPath()%>/consultarMediosPruebaXDatoPrueba.do?audienciaId='+audienciaId+'&idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'',
				<%-- url:'<%=request.getContextPath()%>/consultarMediosPruebaXDatoPrueba.do?idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'', --%>
				datatype: "xml",
				colNames:['Nombre del Medio','N�mero de Identificaci�n'],
				colModel:[
				           	{name:'nombreDato',index:'nombreDato', width:350, align:'center'},
				           	{name:'numIdentificacion',index:'numIdentificacion', width:350, align:'center'},
						],
				pager: jQuery('#pagerGridRelacionarMediosDePruebaPJENS'),
				rowNum:10,
				autoWidth:false,
				width:750,
				height:250,
				//autoheight:true,
				rowList:[10,20,30],
				sortname: 'NombreDato',
				viewrecords: true,
				sortorder: "desc",
				caption:"Medios de Prueba",
				toolbar: [true,"top"],
				multiselect:true
			}).navGrid('#gridRelacionarMediosDePruebaPJENS',{edit:false,add:false,del:false});
			banderaRelacionarMediosPrueba = false;

			$("#t_gridRelacionarMediosDePruebaPJENS").append("<input type='button' class='btn_Generico' value='Agregar' style='height:20px;width:60px;font-size:-3'/>");
			$("input","#t_gridRelacionarMediosDePruebaPJENS").click(function(){
				agregarMedioDePrueba();
			});
		}
		else{
			jQuery("#gridRelacionarMediosDePruebaPJENS").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarMediosPruebaXDatoPrueba.do?audienciaId='+audienciaId+'&idDatoPrueba='+idDatoPrueba+'&numeroExpediente='+numeroExpediente+'',datatype: "xml" });
			$("#gridRelacionarMediosDePruebaPJENS").trigger("reloadGrid");
		}
	}


	/*
	*Funcion que abre la modal para relacionar los datos de prueba
	*con los medios de prueba
	*/
	function asociarDatoPrueba(idDatoPrueba){

		cargaGridImputadosAsociar(idDatoPrueba);
		$("#divAsociarDatoDePruebaPJENS").dialog("open");
		$("#divAsociarDatoDePruebaPJENS").dialog({ autoOpen: true, modal: true,
		title: 'Asociar imputados al dato de prueba',
		dialogClass: 'alert', position: [350,50],
		width: 800, height:480, maxWidth: 800, maxHeight:550,
		buttons:{
			"Asociar":function() {

				var iDsImputados="";
				iDsImputados = jQuery("#gridAsociarDatoDePruebaPJENS").jqGrid('getGridParam','selarrrow');
				guardarAsociacionDatoPrueba(idDatoPrueba,iDsImputados);
			   	$(this).dialog("close");
			},
			"Cancelar":function() {
				customConfirm("�Realmente desea salir?", "", salir);
			}
		}
		});
	}

	function salir(){
  		$("#divAsociarDatoDePruebaPJENS").dialog("close");
	}




	//bandera para controlar el cargado de la asociaci�n de imputados
	banderaAsociarImputado=true;

	/**
	*Funcion que carga el grid con los imputados a asociar
	*/
	function cargaGridImputadosAsociar(idDatoPrueba){

		if(banderaAsociarImputado == true){


			jQuery("#gridAsociarDatoDePruebaPJENS").jqGrid({
				url:'<%=request.getContextPath()%>/consultarImputadosXDatoPrueba.do?idDatoPrueba='+idDatoPrueba+'&idAudiencia='+idAudiencia+'&numeroExpediente='+numeroExpediente+'',
				datatype: "xml",
				colNames:['Nombre del Imputado'],
				colModel:[
				           	{name:'nombreImputado',index:'nombreDato', width:350, align:'center'},
						],

				pager: jQuery('#pagerGridAsociarDatoDePruebaPJENS'),
				rowNum:10,
				autoWidth:false,
				width:750,
				height:250,
				//autoheight:true,
				rowList:[10,20,30],
				sortname: 'NombreDato',
				viewrecords: true,
				sortorder: "desc",
				caption:"Imputados",
				toolbar: [true,"top"],
				multiselect:true
			}).navGrid('#gridAsociarDatoDePruebaPJENS',{edit:false,add:false,del:false});
			banderaAsociarImputado = false;
		}
		else{
			jQuery("#gridAsociarDatoDePruebaPJENS").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarImputadosXDatoPrueba.do?idDatoPrueba='+idDatoPrueba+'&idAudiencia='+idAudiencia+'&numeroExpediente='+numeroExpediente+'',datatype: "xml" });
			$("#gridAsociarDatoDePruebaPJENS").trigger("reloadGrid");
		}
	}


	/**
	*Funcion que guarda la asociacion entre los datos de prueba
	*recibe un arreglo con los ids de los imputados y el id del dato de prueba
	*con el que se asociaran
	*/
	function guardarAsociacionDatoPrueba(idDatoPrueba,iDsImputados){

		$.ajax({
    		type: 'POST',
    		url: '<%= request.getContextPath()%>/asociarImputadoConDatoPrueba.do?iDsImputados='+iDsImputados+'&idDatoPrueba='+idDatoPrueba+'',
    		data:'',
    		dataType:'xml',
    		async:false,
    		success: function(xml){
	   			if(parseInt($(xml).find('code').text())==0)
	    		  {
	   				alertDinamico("La asociaci�n ha sido guardada");
					//Limpiar los ids seleccionados
	   	    	}
	  			else{
	  				alertDinamico("Ocurri� un error durante la asociaci�n");
	      		}
	      		cargaGridPrueba();

    		}
		});
	}


	/*
	*Funcion que despliega la ventana para agregar un dato de prueba
	*/
	function agregarDatoDePrueba(){

		seleccioneTipoDatoPrueba();
		$('#tipoDatoPruebaPJENS').attr('selectedIndex', 0);
		$("#divAgregarDatoDePrueba").dialog("open");
		$("#divAgregarDatoDePrueba").dialog({ autoOpen: true, modal: true,
		title: 'Agregar Dato de Prueba',
		dialogClass: 'alert', position: [500,50],
		width: 595, height: 450, maxWidth: 595,
		buttons:{
			"Agregar":function() {
				guardarDatoPrueba(null);
			   	//$(this).dialog("close");
			},
			"Cancelar":function() {

				customConfirm("�Realmente desea salir del registro del dato de prueba?", "", cancelarAgregarDatoDePrueba);
			}
		}
		});
	}

	function cancelarAgregarDatoDePrueba(){
		limpiarYSalirDatoDePrueba();
  		$("#divAgregarDatoDePrueba").dialog("close");
	}



	/*
	*Funciones para agregar medios de prueba dependiendo de la seleccion
	*/
	function guardarDatoPrueba(datoPruebaId){

		var seleccion = $("#tipoDatoPruebaPJENS option:selected").val();
		var validacion=false;
		var paramDatoPrueba="";

		if(seleccion == "0"){
			validacion=false;
			alertDinamico("Seleccione un tipo de dato de prueba");
		}
		//Validacion de documentos
		if(seleccion == "1"){
			if($('#txtNombreDatoPruebaPJENS').val() == ""){
				alertDinamico("Ingrese un nombre");
			}
			else{
				if($('#txtNumeroIdeDatoPruebaPJENS').val() == ""){
					alertDinamico("Ingrese un n�mero de identificaci�n");
				}
				else{

					if($('#txtAreaDescripcionDatoPruebaPJENS').val() == ""){
						alertDinamico("Ingrese una descripci�n");
					}
					else{
						validacion=true;
						paramDatoPrueba += 'audienciaId=' + audienciaId;
						paramDatoPrueba += '&tipoDatoPrueba=' + "documento";
						paramDatoPrueba += '&nombreDato=' + $('#txtNombreDatoPruebaPJENS').val();
						paramDatoPrueba += '&numIdDato=' + $('#txtNumeroIdeDatoPruebaPJENS').val();
						paramDatoPrueba += '&rccDato=' + $('#txtRccDatoPruebaPJENS').val();
						paramDatoPrueba += '&descDato=' + $('#txtAreaDescripcionDatoPruebaPJENS').val();
						paramDatoPrueba += '&numeroExpediente=' + numeroExpediente;
						paramDatoPrueba += '&datoPruebaId=' + datoPruebaId;
					}
				}
			}
		}

		if(seleccion == "2"){

			if($("#cbxTipoObjetoDatoPruebaPJENS option:selected").val() == "0" ){
				alertDinamico("Seleccione un tipo de objeto");
			}
			else{
				if($('#txtNombreDatoPruebaPJENS').val() == ""){
					alertDinamico("Ingrese un nombre");
				}
				else{
					if($('#txtNumeroIdeDatoPruebaPJENS').val() == ""){
						alertDinamico("Ingrese un n�mero de identificaci�n");
					}
					else{

						if($('#txtAreaDescripcionDatoPruebaPJENS').val() == ""){
							alertDinamico("Ingrese una descripci�n");
						}
						else{
							validacion=true;
							paramDatoPrueba += 'audienciaId=' + audienciaId;
							paramDatoPrueba += '&tipoDatoPrueba=' + "objeto";
							paramDatoPrueba += '&tipoObjetoDatoPrueba=' + $("#cbxTipoObjetoDatoPruebaPJENS option:selected").index();
							paramDatoPrueba += '&nombreDato=' + $('#txtNombreDatoPruebaPJENS').val();
							paramDatoPrueba += '&numIdDato=' + $('#txtNumeroIdeDatoPruebaPJENS').val();
							paramDatoPrueba += '&rccDato=' + $('#txtRccDatoPruebaPJENS').val();
							paramDatoPrueba += '&descDato=' + $('#txtAreaDescripcionDatoPruebaPJENS').val();
							paramDatoPrueba += '&numeroExpediente=' + numeroExpediente;
							paramDatoPrueba += '&datoPruebaId=' + datoPruebaId;
						}
					}
				}
			}
		}

		if(validacion==true){
			$.ajax({
	    		type: 'POST',
	    		url: '<%= request.getContextPath()%>/agregarDatoPrueba.do',
	    		data:paramDatoPrueba,
	    		dataType: 'xml',
	    		async: false,
	    		success: function(xml){
	    			alertDinamico("Dato de prueba registrado correctamente");
	    			$("#divAgregarDatoDePrueba").dialog("close");
	    			limpiarYSalirDatoDePrueba();
	    			cargaGridDatosPrueba();
	    		}
			});
		}
	}


	/*
	*Funcion que controla el mostrar los campos dependiendo de la seleccion
	*del usuario
	*/
	function controlDatoDePrueba(){

		seleccioneTipoDatoPrueba();
		limpiaTipoDatoDePrueba();

		var seleccionTipoDato = $("#tipoDatoPruebaPJENS option:selected").val();

		if(seleccionTipoDato == "0"){
			seleccioneTipoDatoPrueba();
		}
		if(seleccionTipoDato == "1"){

			//Documentos
			seleccioneTipoDatoPrueba();
			$('#etiNombreDatoPruebaPJENS').show();
			$('#divTxtNombreDatoPruebaPJENS').show();
			$('#etiNumIdeDatoPruebaPJENS').show();
			$('#divTxtNumeroIdeDatoPruebaPJENS').show();
			$('#etiRccDatoPruebaPJENS').show();
			$('#divTxtRccDatoPruebaPJENS').show();
			$('#etiDescripcionPJENS').show();
			$('#divTxtAreaDescripcionDatoPruebaPJENS').show();
		}
		if(seleccionTipoDato == "2"){

			//Objetos
			seleccioneTipoDatoPrueba();
			consultarCatalogoDeObjetosDatoDePrueba();
			$('#etiTipoObjetoDatoPruebaPJENS').show();
			$('#divCbxTipoObjetoDatoPruebaPJENS').show();
			$('#etiNombreDatoPruebaPJENS').show();
			$('#divTxtNombreDatoPruebaPJENS').show();
			$('#etiNumIdeDatoPruebaPJENS').show();
			$('#divTxtNumeroIdeDatoPruebaPJENS').show();
			$('#etiRccDatoPruebaPJENS').show();
			$('#divTxtRccDatoPruebaPJENS').show();
			$('#etiDescripcionPJENS').show();
			$('#divTxtAreaDescripcionDatoPruebaPJENS').show();

		}
	}

	/*
	*Oculta todos los div de todos los objetos
	*/
	function seleccioneTipoDatoPrueba(){

		$('#etiTipoObjetoDatoPruebaPJENS').hide();
		$('#divCbxTipoObjetoDatoPruebaPJENS').hide();

		$('#etiNombreDatoPruebaPJENS').hide();
		$('#divTxtNombreDatoPruebaPJENS').hide();

		$('#etiNumIdeDatoPruebaPJENS').hide();
		$('#divTxtNumeroIdeDatoPruebaPJENS').hide();

		$('#etiRccDatoPruebaPJENS').hide();
		$('#divTxtRccDatoPruebaPJENS').hide();

		$('#etiDescripcionPJENS').hide();
		$('#divTxtAreaDescripcionDatoPruebaPJENS').hide();
	}

	/*
	*Funcion que carga los combos de las de objetos
	*/
	function consultarCatalogoDeObjetosDatoDePrueba() {
     $.ajax({
    	  type: 'POST',
    	  url: '<%= request.getContextPath()%>/consultarTiposObjeto.do',
    	  data: '',
    	  async: false,
    	  dataType: 'xml',
    	  success: function(xml){
	    	  $('#cbxTipoObjetoDatoPruebaPJENS').empty();
	    	  $('#cbxTipoObjetoDatoPruebaPJENS').append('<option value="0">- Seleccione -</option>');
	    	  $(xml).find('catTipoObjetos').each(function(){
				$('#cbxTipoObjetoDatoPruebaPJENS').append('<option value="' + $(this).find('valor').text() + '">' + $(this).find('valor').text() + '</option>');
				});
    	  }
    	});
	}


	/*
	*Limpia todos los campos de todos los objetos
	*/
	function limpiaTipoDatoDePrueba(){

		$('#txtAreaDescripcionDatoPruebaPJENS').val("");
		$('#txtRccDatoPruebaPJENS').val("");
		$('#txtNumeroIdeDatoPruebaPJENS').val("");
		$('#txtNombreDatoPruebaPJENS').val("");
		$('#cbxTipoObjetoDatoPruebaPJENS').attr('selectedIndex', 0);
	}

	/*
	*Funcion que limpia todos los campos al salir de la ventana
	*y setea el valor seleccione por default
	*/
	function limpiarYSalirDatoDePrueba(){
		limpiaTipoDatoDePrueba();
		$('#tipoDatoPruebaPJENS').attr('selectedIndex',0);

	}


	/*
	*Funcion que despliega la ventana para agregar un Medio de prueba
	*/
	function agregarMedioDePrueba(){

		seleccioneTipoMedioPrueba();
		$('#tipoMediaPruebaPJENS').attr('selectedIndex', 0);
		controlMedioDePrueba();
		$("#divAgregarMedioDePrueba").dialog("open");
		$("#divAgregarMedioDePrueba").dialog({ autoOpen: true, modal: true,
		title: 'Medio de Prueba',
		dialogClass: 'alert', position: [500,50],
		width: 495, height: 400, maxWidth: 495,
		buttons:{
			"Agregar":function() {
				guardarMedioDePrueba();
				//limpiaTipoMediaPrueba();
			   	//$(this).dialog("close");
			},
			"Cancelar":function() {

				customConfirm("�Realmente desea salir del registro del medio de prueba?", "", cancelarAgregarMedioDePrueba);
			}
		}
		});
	}

	function cancelarAgregarMedioDePrueba(){
		limpiarYSalirMedioPrueba();
  		$("#divAgregarMedioDePrueba").dialog("close");
	}



	/*
	*Funciones para agregar medios de prueba dependiendo de la seleccion
	*/
	function guardarMedioDePrueba(){

		var seleccion = $("#tipoMediaPruebaPJENS option:selected").val();
		var paramMedioPrueba="";

		if(seleccion == "0"){

			alertDinamico("Seleccione un tipo de medio de prueba");
		}
		//Validacion de documentos
		if(seleccion == "1"){
			if($("#cbxSubTipoDocumentoMedioPruebaPJENS option:selected").val() == "0"){
				alertDinamico("Ingrese un subtipo de documento");
			}
			else{
				if($('#txtNombreDocumentoMedioPruebaPJENS').val() == ""){
					alertDinamico("Ingrese un nombre");
				}
				else{
					if($('#txtNumeroIdeDocumentoMedioPruebaPJENS').val() == ""){
						alertDinamico("Ingrese un n�mero de identificaci�n");
					}
					else{
						if($('#archivoPorSubir').val() == ""){
							alertDinamico("Adjunte un archivo");
						}
						else{
							if($('#txtAreaDescripcionDocMedioPruebaPJENS').val() == ""){
								alertDinamico("Ingrese una descripci�n");
							}
							else{

								guardarMedioPruebaConDocDig();
								alertDinamico("El medio de prueba ha sido guardado \n y relacionado al dato");
								$("#divAgregarMedioDePrueba").dialog("close");
								$("#divRelacionarMediosDePruebaPJENS").dialog("close");
								cargaGridMediosDePrueba();
							}
					}
				}
			}
		}
		}

		if(seleccion == "2"){
			$("#divAgregarMedioDePrueba").dialog("close");
			creaNuevoIndividuo(<%=Calidades.TESTIGO.getValorId()%>);
		}
	}

	//funcion que guarda las solicitudes de audiencia, de transcripcion de audiencia y  de audio/video
	function guardarMedioPruebaConDocDig(){


			forma = document.medioPruebaForm;

			forma.datoPruebaId.value= jQuery("#gridDatosDePruebaPJENS").jqGrid('getGridParam','selrow');
			forma.audienciaId.value = audienciaId;
			forma.tipoMedioPrueba.value = "documento";
			forma.subTipoMedioPrueba.value = $("#cbxSubTipoDocumentoMedioPruebaPJENS option:selected").index();
			forma.nombreDoc.value = $('#txtNombreDocumentoMedioPruebaPJENS').val();
			forma.numIdDoc.value = $('#txtNumeroIdeDocumentoMedioPruebaPJENS').val();
			forma.refUbicacionFisica.value = $('#txtRefUbicacionFisicaMedioPruebaPJENS').val();
			forma.descDocumento.value = $('#txtAreaDescripcionDocMedioPruebaPJENS').val();
			forma.numeroExpediente.value = numeroExpediente;
			forma.submit();
	}

	//Variable para controlar el id de las ventanas
	var idWindowIngresarIndividuoMedioPrueba=1;

	/*
	*Crea una nueva ventana para ingresar individuos
	*/
	function creaNuevoIndividuo(calidad) {

		$("#divRelacionarMediosDePruebaPJENS").dialog("close");
		var stringCalidad = "";
		var datoPrueba;

		var idDatoPrueba = jQuery("#gridDatosDePruebaPJENS").jqGrid('getGridParam','selrow');
		if(idDatoPrueba){

			datoPrueba = jQuery("#gridDatosDePruebaPJENS").jqGrid('getRowData',idDatoPrueba);
		}

		switch(parseInt(calidad)){

			case <%=Calidades.TESTIGO.getValorId()%>:
				stringCalidad="Testigo";
			break;

			case <%=Calidades.PROBABLE_RESPONSABLE_PERSONA.getValorId()%>:
				stringCalidad="Probable Responsable";
			break;

			case 3:
				stringCalidad="Perito";
			break;

			case 4:
				stringCalidad="Polic�a ministerial";
			break;

			default: alertDinamico("Error, calidad no encontrada");
		}

		idWindowIngresarIndividuoMedioPrueba++;

		var idWindow = "iframewindowIngresarIndividuo" + idWindowIngresarIndividuoMedioPrueba;

		$.newWindow({id:"iframewindowIngresarIndividuo" + idWindowIngresarIndividuoMedioPrueba, statusBar: true, posx:200,posy:50,width:1050,height:600,title:"Ingresar: "+stringCalidad+" - Relacionado a: "+datoPrueba.nombreDato, type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarIndividuo" + idWindowIngresarIndividuoMedioPrueba,'<iframe src="<%= request.getContextPath() %>/IngresarTestigoPJENS.do?audienciaId='+audienciaId+'&numeroExpediente='+numeroExpediente +'&calidad='+calidad+'&idDatoPrueba='+idDatoPrueba+'&idWindow='+idWindow+'" width="1050" height="600" />');
	    $("#iframewindowIngresarIndividuo"+idWindowIngresarIndividuoMedioPrueba+".window-closeButton").fadeIn();
	    //$("#divRelacionarMediosDePruebaPJENS").dialog("open");
	}

	/*
	*Funcion que controla el mostrar los campos dependiendo de la seleccion
	*del usuario
	*/
	function controlMedioDePrueba(){

		var seleccionTipoMedio = $("#tipoMediaPruebaPJENS option:selected").val();

		limpiaTipoMediaPrueba();

		if(seleccionTipoMedio == "0"){
			seleccioneTipoMedioPrueba();
		}
		if(seleccionTipoMedio == "1"){
			seleccioneTipoMedioPrueba();
			//Documentos
			$('#etiSubTipoDocumentoMedioPruebaPJENS').show();
			$('#etiNombreDocumentoMedioPruebaPJENS').show();
			$('#etiNumeroIdeDocumentoMedioPruebaPJENS').show();
			$('#etiAdjuntarDocumentoMedioPruebaPJENS').show();
			$('#etiRefUbicacionDocumentoMedioPruebaPJENS').show();
			$('#etiDescripcionDocMedioPruebaPJENS').show();
			$('#divSubTipoDocumentoMedioPruebaPJENS').show();
			$('#divTxtNombreDocumentoMedioPruebaPJENS').show();
			$('#divNumeroIdeDocumentoMedioPruebaPJENS').show();
			$('#divTxtAdjuntarDocumentoMedioPruebaPJENS').show();
			$('#divTxtRefUbicacionFisicaMedioPruebaPJENS').show();
			$('#divTxtAreaDescripcionDocMedioPruebaPJENS').show();
		}
		if(seleccionTipoMedio == "2"){
			seleccioneTipoMedioPrueba();
			//Persona
			//$('#etiCalidadPersonaMedioPruebaPJENS').show();
			//$('#divCbxCalidadPersonaMedioPruebaPJENS').show();
		}
	}


	/*
	*Oculta todos los div de todos los objetos
	*/
	function seleccioneTipoMedioPrueba(){
		//Documentos
		$('#etiSubTipoDocumentoMedioPruebaPJENS').hide();
		$('#etiNombreDocumentoMedioPruebaPJENS').hide();
		$('#etiNumeroIdeDocumentoMedioPruebaPJENS').hide();
		$('#etiAdjuntarDocumentoMedioPruebaPJENS').hide();
		$('#etiRefUbicacionDocumentoMedioPruebaPJENS').hide();
		$('#etiDescripcionDocMedioPruebaPJENS').hide();
		$('#divSubTipoDocumentoMedioPruebaPJENS').hide();
		$('#divTxtNombreDocumentoMedioPruebaPJENS').hide();
		$('#divNumeroIdeDocumentoMedioPruebaPJENS').hide();
		$('#divTxtAdjuntarDocumentoMedioPruebaPJENS').hide();
		$('#divTxtRefUbicacionFisicaMedioPruebaPJENS').hide();
		$('#divTxtAreaDescripcionDocMedioPruebaPJENS').hide();
		//Persona
		//$('#etiCalidadPersonaMedioPruebaPJENS').hide();
		//$('#divCbxCalidadPersonaMedioPruebaPJENS').hide();
	}


	/*
	*Limpia todos los campos de todos los objetos
	*/
	function limpiaTipoMediaPrueba(){

		//DOCUMENTOS
		$('#cbxSubTipoDocumentoMedioPruebaPJENS').attr('selectedIndex', 0);
		$('#txtNombreDocumentoMedioPruebaPJENS').val("");
		$('#txtNumeroIdeDocumentoMedioPruebaPJENS').val("");
		//resetea la forma
		document.medioPruebaForm.reset();
		$('#txtRefUbicacionFisicaMedioPruebaPJENS').val("");
		$('#txtAreaDescripcionDocMedioPruebaPJENS').val("");

		//PERSONA
		$('#cbxCalidadPersonaMedioPruebaPJENS').attr('selectedIndex', 0);


	}

	/*
	*Funcion que limpia todos los campos al salir de la ventana
	*y setea el valor seleccione por default
	*/
	function limpiarYSalirMedioPrueba(){
		limpiaTipoMediaPrueba();
		$('#tipoMediaPruebaPJENS').attr('selectedIndex',0);

	}

	//Funcion que carga los combos de las de objetos
	function consultarCatalogoDeObjetos() {
     $.ajax({
    	  type: 'POST',
    	  url: '<%= request.getContextPath()%>/consultarTiposObjeto.do',
    	  data: '',
    	  async: false,
    	  dataType: 'xml',
    	  success: function(xml){
	    	  $('#cbxTipoObjetoMedioPruebaPJENS').empty();
	    	  $('#cbxTipoObjetoMedioPruebaPJENS').append('<option value="0">- Seleccione -</option>');
	    	  $(xml).find('catTipoObjetos').each(function(){
				$('#cbxTipoObjetoMedioPruebaPJENS').append('<option value="' + $(this).find('valor').text() + '">' + $(this).find('valor').text() + '</option>');
				});
    	  }
    	});
	}


	//////////////////////FUNCIONALIDAD PARA LA SUB CEJA MEDIOS DE PRUEBA

	var banderaMediosPrueba = true;
	/*
	*Funcion que carga el grid de medios de prueba
	*/
	function cargaGridMediosDePrueba(){

		if(banderaMediosPrueba == true){

			jQuery("#gridMediosDePruebaPJENS").jqGrid({

				<%-- url:'<%=request.getContextPath()%>/consultarMediosPruebaAsociadosAlExpediente.do?idDatoPrueba=null&numeroExpediente='+numeroExpediente+'', --%>
				url:'<%=request.getContextPath()%>/consultarMediosPruebaAsociadosAlExpediente.do?idDatoPrueba='+idAudiencia+'&numeroExpediente='+numeroExpediente+'',
				datatype: "xml",
				colNames:['Nombre del Medio','N�mero de Identificaci�n'],
				colModel:[
				           	{name:'nombreMedio',index:'nombreMedio', width:350, align:'center'},
				           	{name:'numIdentificacion',index:'numIdentificacion', width:350, align:'center'},
						],
				pager: jQuery('#pagerGridMediosDePruebaPJENS'),
				rowNum:10,
				autoWidth:false,
				width:750,
				//height:250,
				autoheight:true,
				rowList:[10,20,30],
				sortname: 'nombreMedio',
				viewrecords: true,
				sortorder: "desc",
				caption:"Resumen de medios de prueba",
				toolbar: [true,"top"],
				//multiselect:true,
				ondblClickRow: function(rowid) {
					consultarMedioDePrueba(rowid);
				}
			}).navGrid('#pagerGridMediosDePruebaPJENS',{edit:false,add:false,del:false});
			//$("#gview_gridMediosDePruebaPJENS .ui-jqgrid-bdiv").css('height', '200px');
			banderaMediosPrueba = false;
			//$("#t_gridMediosDePruebaPJENS").append("<input type='button' id='btnAgregarMedioPrueba' class='btn_grande' value='Agregar' style='height:20px;width:60px;font-size:-3'/>"+" "+"<input type='button' id='btnDesahogarMedioPrueba' class='btn_grande' value='Desahogar' style='height:20px;width:70px;font-size:-3'/>");
			//$("#btnAgregarMedioPrueba","#t_gridMediosDePruebaPJENS").click(function(){
			//	agregarMedioDePrueba();
			//});

			//$("#t_gridMediosDePruebaPJENS").append("<input type='button' id='btnDesahogarMedioPrueba' class='btn_grande' value='Desahogar' style='height:20px;width:70px;font-size:-3'/>");
			//$("#btnDesahogarMedioPrueba","#t_gridMediosDePruebaPJENS").click(function(){
			//});
		}
		else{

			jQuery("#gridMediosDePruebaPJENS").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarMediosPruebaAsociadosAlExpediente.do?idDatoPrueba='+idAudiencia+'&numeroExpediente='+numeroExpediente+'',datatype: "xml" });
			<%-- jQuery("#gridMediosDePruebaPJENS").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarMediosPruebaAsociadosAlExpediente.do?idDatoPrueba=null&numeroExpediente='+numeroExpediente+'',datatype: "xml" }); --%>
			$("#gridMediosDePruebaPJENS").trigger("reloadGrid");
		}
	}


	//variable usada para asignarle id a la ventana de consultar datos de prueba
	var consultarMedioDePruebaWindow = 1;

	/*
	*Funcion para consultar datos de prueba vs medios de prueba
	*/
	function consultarMedioDePrueba(idMedioPrueba){

		consultarMedioDePruebaWindow++;
		$.newWindow({id:"iframewindowConsultarMedioDePrueba"+consultarMedioDePruebaWindow, statusBar: true, posx:180,posy:60,width:1140,height:420,title:"Consultar Medio de Prueba", type:"iframe"});
    	$.updateWindowContent("iframewindowConsultarMedioDePrueba"+consultarMedioDePruebaWindow,'<iframe src="<%= request.getContextPath() %>/consultarDetalleMedioPruebaPJENS.do?idMedioPrueba='+idMedioPrueba+'" width="1140" height="420" />');
	}

	//////////////////////FUNCIONALIDAD PARA LA SUB CEJA DE PRUEBA


	var banderaPrueba = true;
	/*
	*Funcion que carga el grid de medios de prueba
	*/
	function cargaGridPrueba(){

		if(banderaPrueba == true){

			jQuery("#gridPruebaPJENS").jqGrid({
				url:'<%=request.getContextPath()%>/consultarPruebasPorNumeroExpediente.do?audienciaId='+audienciaId+'&numeroExpediente='+numeroExpediente+'',
				<%-- url:'<%=request.getContextPath()%>/consultarPruebasPorNumeroExpediente.do?numeroExpediente='+numeroExpediente+'', --%>
				datatype: "xml",
				colNames:['Prueba Aceptada','N�mero de Identificaci�n','Reg. de Cadena de Custodia', 'No. de Imputados Asociados', 'Imputados'],
				colModel:[
				           	{name:'nombrePrueba',index:'nombrePrueba', width:200, align:'center'},
				           	{name:'numIdentificacion',index:'numIdentificacion', width:180, align:'center'},
				        	{name:'rcc',index:'rcc', width:200, align:'center'},
				           	{name:'noProbRespAsociados',index:'numIdentificacion', width:100, align:'center'},
				        	{name:'probablesResponsables',index:'rcc', width:200, align:'center'}
						],
				pager: jQuery('#pagerGridPruebaPJENS'),
				rowNum:10,
				autoWidth:true,
				width:'auto',
				shrinkToFit:true,
				altRows : true,
				height:250,
				//autoheight:true,
				rowList:[10,20,30],
				sortname: 'nombreMedio',
				viewrecords: true,
				sortorder: "desc",
				caption:"Resumen de medios de prueba",
				toolbar: [true,"top"]
			}).navGrid('#pagerGridPruebaPJENS',{edit:false,add:false,del:false});

			$("#gview_gridPruebaPJENS .ui-jqgrid-bdiv").css('height', '200px');

			banderaPrueba = false;

			//Boton para asociar las pruebas a involucrados
			$("#t_gridPruebaPJENS").append("<input type='button' id='btnAsociarPrueba' class='btn_Generico' value='Asociar' style='height:20px;width:60px;font-size:-3'/>");

			//Funcionalidad para al boton asociar
			$("#btnAsociarPrueba","#t_gridPruebaPJENS").click(function(){

				var rowid = jQuery("#gridPruebaPJENS").jqGrid('getGridParam','selrow');

				if(rowid){

					asociarDatoPrueba(rowid);
				}
				else{
					alertDinamico("Seleccione una prueba a asociar");
				}

			});
		}
		else{
			jQuery("#gridPruebaPJENS").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarPruebasPorNumeroExpediente.do?audienciaId='+audienciaId+'&numeroExpediente='+numeroExpediente+'',datatype: "xml" });
			$("#gridPruebaPJENS").trigger("reloadGrid");
		}
	}
//*********************************************************TERMINA FUCIONALIDAD PARA LA CEJA PRUEBAS******************************************************************/







//*****************************************************FUNCIONALIDAD DE LA CEJA RESOLUTIVOS DE AUDIENCIA**********************************************************\
	/*
	*Carga el grid de los resolitivos de audiencia
	*/
	function cargaGridResolutivosDeAudiencia(idEvento){

		jQuery("#gridAudienciasResolutivosPJENS").jqGrid({
			url:'<%=request.getContextPath()%>/consultarResolutivosAudienciaPJENS.do?idEvento='+ idEvento,
			datatype: "xml",
			colNames:['Temp. Video','Resolutivo',],
			colModel:[ 	{name:'temporizadorVideo',index:'temporizadorVideo', width:150, align:"center"},
						{name:'resolutivo',index:'resolutivo', width:400,align:"center"}
					],
			pager: jQuery('#pager5'),
			rowNum:10,
			rowList:[10,20,30],
			width: 725,
			autoheight: true,
			sortname: 'detalle',
			scrollrows : true,
			viewrecords: true,
			sortorder: "desc",
			editurl: "http://localhost:8080/nsjp-web/encargadoSala.jsp",
			loadComplete: function(){
				var registros =jQuery("#gridAudienciasResolutivosPJENS").jqGrid('getDataIDs');
				var total = registros.length;
				$("#gridAudienciasResolutivosPJENS").jqGrid('setSelection',registros[total-1]);

			 },
			ondblClickRow: function(id){
				var data = jQuery("#gridAudienciasResolutivosPJENS").jqGrid('getRowData',id);
				modificarResolutivo(id, data);
			}
		}).navGrid('#pager5',{edit:false,add:false,del:false});
	}


	/*
	*Funcion que despliega la ventana para agregar un resolutivo
	*/
	function agregarRegistrarResolutivo(){

		$('#tempVideo').val("");
		cargaHoraCaptura();
		$('#resolutivo').val("");
		$("#divAgregarResolutivo").dialog("open");
		$("#divAgregarResolutivo").dialog({ autoOpen: true, modal: true,
		title: 'Agregar Resolutivo',
		dialogClass: 'alert', position: [150,50],
		width:550,
		height:400,
		maxWidth:550,
		maxHeight:400,
		buttons:{
			"Guardar":function() {
				//Enable JC Permitir el cambio de hora de los resolutivos
				var txtHora = $('#tempVideo').val();
				if(isFormatoHora(txtHora)){
					var datosResolutivos="";
					datosResolutivos += 'tempVideo=' + $('#tempVideo').val();
					datosResolutivos += '&resolutivo=' + $('#resolutivo').val();

					$.ajax({
						url: '<%= request.getContextPath()%>/registrarResolutivosPJENS.do?idEvento='+idAudiencia+'',
						type: 'POST', data: datosResolutivos, async: false, dataType: 'xml',
						success: function(xml){$("#gridAudienciasResolutivosPJENS").trigger("reloadGrid");}
					});

				   	$(this).dialog("close");
				}else{
					var msjError = "La hora debe coincidir con el formato HH:MM:SS. HH de 00 a 23, MM de 00 a 59, SS de 00 a 59.s";
					var tituloMsj = "Formato de hora inv�lido";
					customAlert(msjError, tituloMsj);
				}
			},
			"Cancelar":function() {

				customConfirm("�Realmente desea salir de el registro de un resolutivo?", "", cancelarAgregarRegistrarResolutivo);
			}
		}
		});
	}



	function cancelarAgregarRegistrarResolutivo(){
  		$("#divAgregarResolutivo").dialog("close");
	}



	/*
	*Funcion para modificar el resolutivo seleccionado
	*/
	function modificarResolutivo(id, data){

		$('#tempVideo').val(data.temporizadorVideo);
		$('#resolutivo').val(data.resolutivo);
		$("#divAgregarResolutivo").dialog("open");
		$("#divAgregarResolutivo").dialog({ autoOpen: true, modal: true,
		title: 'Agregar Resolutivo',
		dialogClass: 'alert', position: [150,50],
		width:550,
		height:400,
		maxWidth:550,
		maxHeight:400,
		buttons:{"Guardar":function() {
			//Enable JC Permitir el cambio de hora de los resolutivos
			var txtHora = $('#tempVideo').val();
			if(isFormatoHora(txtHora)){
				var datosResolutivos="";
				datosResolutivos += 'idResolutivo=' + id;
				datosResolutivos += '&tempVideo=' + $('#tempVideo').val();
				datosResolutivos += '&resolutivo=' + $('#resolutivo').val();
				$.ajax({
					url: '<%= request.getContextPath()%>/modificarResolutivosPJENS.do',
					type: 'POST', data: datosResolutivos, async: false, dataType: 'xml',
					success: function(xml){$("#gridAudienciasResolutivosPJENS").trigger("reloadGrid");}
				});
		   		$(this).dialog("close");
			}else{
				var msjError = "La hora debe coincidir con el formato HH:MM:SS. HH de 00 a 23, MM de 00 a 59, SS de 00 a 59.s";
				var tituloMsj = "Formato de hora inv�lido";
				customAlert(msjError, tituloMsj);
			}
		},
		"Cancelar":function() {

			customConfirm("�Realmente desea salir de la modicai�n de un resolutivo?", "", cancelarModificarResolutivo);

		}
		  	}
		});
	}


	function cancelarModificarResolutivo(){
  		$("#divAgregarResolutivo").dialog("close");
	}



	/*
	*Funcion para eliminar un registro de resolutivo
	*/
	function eliminarRegistroResolutivo(){

		var gr = jQuery("#gridAudienciasResolutivosPJENS").jqGrid('getGridParam','selrow');
		var datosResolutivos="";

		datosResolutivos += 'idResolutivo=' + gr;
		$.ajax({
			url: '<%= request.getContextPath()%>/eliminarResolutivosPJENS.do',
			type: 'POST', data: datosResolutivos, async: false, dataType: 'xml',
			success: function(xml){$("#gridAudienciasResolutivosPJENS").trigger("reloadGrid");}
		});
	}


	/*
	*Funcion que carga la hora actual
	*/
	function cargaHoraCaptura(){

	  	$.ajax({
	  		type: 'POST',
	  	    url: '<%= request.getContextPath()%>/ConsultarHoraCaptura.do',
	  	    data: '',
	  	    dataType: 'xml',
	  	    success: function(xml){
	  			$('#tempVideo').val($(xml).find('horaActual').text());
	  		}
		});
	}


	/*
	*Funcion que abre el tipo de ley seleccionada
	*/
	function abreCodigosLeyes(tipo) {

		 tipoLey = tipo;

		 jQuery("#gridLeyesCodigosPJENS").jqGrid('setGridParam', {postData: {tipoLey: tipoLey}});
		 $("#gridLeyesCodigosPJENS").trigger("reloadGrid");

		jQuery("#gridLeyesCodigosPJENS").jqGrid({
			url:'<%= request.getContextPath()%>/consultarLeyesCodigos.do',
			datatype: "xml",
			colNames:['Consulta de Leyes y Codigos'],
			colModel:[ 	{name:'ley',index:'ley', width:500,align:"center"} ],
			pager: jQuery('#pager10'),
			rowNum:10,
			rowList:[10,20,30],
			autowidth: true,
			height: 220,
			sortname: 'detalle',
			viewrecords: true,
			sortorder: "desc",
			onCellSelect: function(id,fila,contenido){
				abrirPDF(id,fila,contenido);
				}
			}).navGrid('#pager10',{edit:false,add:false,del:false});

	}

	/*
	*Funcion que da un submit a la forma para mostrar las leyes
	*/
	function abrirPDF(idLey,fila,contenido){

		document.frmDoc.idLey.value = idLey;
		document.frmDoc.nombreArchivo.value = contenido;
		document.frmDoc.submit();
	}

	function Resolutivo(temporizadorVideo, resolutivo){
		this.temporizadorVideo = temporizadorVideo;
		this.resolutivo = resolutivo;
	}


//**********************************************************FUNCIONALIDAD DE LA CEJA PROGRAMAR AUDIENCIA**********************************************************\

	//FUNCIONALIDAD COMUN A LAS 3 SUB CEJAS

	/*
	*Funcionalidad para obtener el id de la audiencia siguiente
	*/
	function recuperaIdSiguienteAudiencia(){

		$.ajax({
			type: 'POST',
			url: '<%=request.getContextPath()%>/recuperaIdSiguienteAudiencia.do',
			data: 'idAudiencia='+ idAudiencia,
			async: false,
			dataType: 'xml',
			success: function(xml){
				idAudienciaSiguiente=$(xml).find('long').text();
			}
		});
	}


	/*
	*Funcion que oculta las cejas de involucrados y objetos
	*de la ceja programar audiencia
	*/
	function ocultaSubCejasProgAudiencia(){
		$("#tabschild").tabs("option", "disabled", [1,2,3,4,5,6,7,8]);
	  }

	/*
	*Habilita el tab de Involucrados y el teb de objetos
	*/
	function muestraSubCejasProgAudiencia(){
		$('#tabschild').tabs('enable', 1);
		$('#tabschild').tabs('enable', 2);
		$('#tabschild').tabs('enable', 3);
		$('#tabschild').tabs('enable', 4);
		$('#tabschild').tabs('enable', 5);
		$('#tabschild').tabs('enable', 6);
		$('#tabschild').tabs('enable', 7);
		$('#tabschild').tabs('enable', 8);
	}

	/**
	*Funcion que recarga el grid con la funcionalidad de la agenda
	*/
	function cargaGridAgenda(){

		jQuery("#gridAgendaPJENA").jqGrid({
			url:'<%=request.getContextPath()%>/calendarioActual.do',
			datatype: "xml",
			colNames:['Lu','Ma','Mi','Ju','Vi','Sa','Do'],
			colModel:[  {name:'lunes',index:'lunes', width:40, align:'center'},
			           	{name:'martes',index:'martes', width:40, align:'center'},
			           	{name:'miercoles',index:'miercoles', width:40,align:'center'},
			           	{name:'jueves',index:'jueves', width:40, align:'center'},
			           	{name:'viernes',index:'viernes', width:40, align:'center'},
			           	{name:'sabado',index:'sabado', width:40, align:'center'},
			           	{name:'domingo',index:'domingo', width:40, align:'center'},

					],
			rowNum:10,
			rowList:[10,20,30],
			sortname: 'detalle',
			viewrecords: true,
			sortorder: "desc",
			cellEdit: true,
			scrollOffset:0,
			onSelectCell: function(idRow,dia,fecha) {
				seleccionCelda(idRow,dia,fecha);
				deshabilitarHabilitarComponentes("seleccionFecha");
					},
			loadComplete: function(){
				//Cambia la bandera para avanzar de mes
				banderaCambio=0;
			}
		});
	}

	/*
	*Funcion que consulta el detalle del evento y llena
	*los campos de la TAB Detalle evento
	*/
	function formateaFechaHora(fechaHora){

		var fechaFrac = fechaHora.split(" ")[0];
		var horaFrac = fechaHora.split(" ")[1];

		horaFracPos = horaFrac.indexOf(":", 0);
		hora=horaFrac.substring(0,horaFracPos+3);

		$("#fechaAudienciaPJENS,#textFecha").val(fechaFrac);
		$("#horaAudienciaPJENS,#textHora").val(hora);
	}

	/*
	*Funcion que carga los combos de tipo de solicitudes de audiencia que se pueden realizar
	*excepto el tipo de audiencia actual
	*/
	function cargaComboTipoAudiencia(tipoAudiencia) {

		$.ajax({
			type: 'POST',
			<%-- url: '<%= request.getContextPath()%>/consultarCatalogoTipoAudienciaValidacion.do', --%>
			/* Enable IT: Se quita consulta con validaci�n para el flujo de las audiencias */
			url: '<%= request.getContextPath()%>/consultarCatalogoTipoAudiencia.do',
			data: 'tipoAudiencia='+tipoAudiencia,
			async: false,
			dataType: 'xml',
			success: function(xml){
				$('#tipoAudienciaProgramarAudiencia').empty();
				$('#tipoAudienciaProgramarAudiencia').append('<option value="0">- Seleccione -</option>');
				var tipoAud = "";
				$(xml).find('institucion').each(function(){
					$('#tipoAudienciaProgramarAudiencia').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}


	//COMIENZA FUNCIONALIDAD DEL CALENDARIO

	/**
	*Funcion que obtiene el valor del desplazamiento para los meses "atras" o "adelante",
	*pasa el valor al action para que este ejecute el movimiento y recarga el grid de
	*agenda
	*/
	function atrasAdelanteMes(movimiento){
		recorridoMeses(movimiento);
		jQuery("#gridAgendaPJENA").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/calendarioActual.do?mov='+ movimiento +'',datatype: "xml" });
		$("#gridAgendaPJENA").trigger("reloadGrid");
	}

	/**
	*Funcion que recorre el carrusel de los mese y anio si la bandera de cambio se encuentra encendida
	*los meses no se recorran, hasta que el grid sea refrescado y baje la bandera
	*/
	function recorridoMeses(movimiento){

		if(banderaCambio==0){
			if(movimiento=="atras"){

				if(mesActual == 0){
					mesActual=11;
					if(anioActual == 0)
						anioActual=3000;
					else
						anioActual--;
				}

				else
					mesActual--;
			}
			else{
				if(mesActual == 11){
					mesActual=0;
					anioActual++;
				}
				else
					mesActual++;
			}
			var mesSeleccionado = meses[mesActual];

			//setea los valor de mes y anio a la caja de texto
			$('#mes').val(mesSeleccionado);
			$('#anio').val(anioActual);
			//levanta la bandera de cambio
			banderaCambio=1;
		}
	}

	/*
	*Verifica el tipo de audiencia y en el caso de ser de juicio oral
	*ordena se capturen el numero de jueces correspondientes al tipo
	*/
	function verificarTipoAudiencia(automatico){

		//Si pulso autom�ticamente
		if(automatico == true){
			//jQuery("#gridSolicitudDeAudienciaJuecesPJENA").setGridParam({multiselect:false}).hideCol('cb');
			$("#gridSolicitudDeAudienciaJuecesPJENA").unbind('click');
			multiselect=0;
		}
		//Si pulso manualmente
		else{

			if(tipoAudiencia=="Juicio Oral" || tipoAudiencia=="jucio oral" || tipoAudiencia == "Juicio oral" || tipoAudiencia == "juicio Oral"){
			 	if($("#juezSustituto").is(':checked')){
			 		alertDinamico("Por favor seleccione 4 jueces del listado");
					multiselect=4;
				}else{
					alertDinamico("Por favor seleccione 3 jueces del listado");
				 	multiselect=3;
				}
			}else{
				alertDinamico("Por favor seleccione un juez del listado");
				multiselect=1;
			}
		}

	}


	//COMIENZA FUNCIONALIDAD DEL CALENDARIO //


	/**
	*Funcion que obtiene el valor de la celda seleccionada en la agenda
	*/
	function seleccionCelda(idRow,dia,fecha){

		//verifica si la sub string inhabil se encuentra en la cadena fecha,
		//de NO ser asi devuelve -1
		if(fecha.indexOf("inhabil")==-1){
			var fechaPos1=fecha.indexOf(">", 0);
			var fechaPos2=fecha.indexOf("<", fechaPos1);
			fechaReal="";
			fechaReal=fecha.substring(fechaPos1+1, fechaPos2);
			muestraFechaSeleccionada(fechaReal);
			controlSalas(fechaReal);
			//$("#gridAgendaPJENA").jqGrid('setCell',"1","lunes","",{'font-weight': 'bold',color: 'white','text-align':'center','background-color':'red'});
		}
		else{
			alertDinamico("Seleccione un d�a h�bil");
		}
	}

	/**
	*funcion que muestra en el txtField la fecha seleccionada en el calendario
	*/
	function muestraFechaSeleccionada(){

		var contadorMeses = 0;
		var mesDisponible = $('#mes').val();
		var anioDisponible = $('#anio').val();

		while(mesDisponible != meses[contadorMeses]){
			contadorMeses++;
		}

		var diaDisponible;
		if(fechaReal < 10){
			diaDisponible= "0"+fechaReal;
		}
		else{
			diaDisponible=fechaReal;
		}
		contadorMeses++;
		if((contadorMeses) < 10){
			//$('#fechaSeleccionadaAudiencia').val(fechaReal+"/"+"0"+contadorMeses+"/"+anioDisponible);
			contadorMeses = "0"+contadorMeses;
		}
		$('#fechaSeleccionadaAudiencia').val(diaDisponible+"/"+contadorMeses+"/"+anioDisponible);
	}

	var numeroDeSalas=0;

	/**
	*Funcion que controla la agenda de las salas
	*/
	function controlSalas(fechaReal){

		if(primeraConsulta=="true"){
			numeroDeSalas=obtenerNumeroDeSalas();
			insertaTablas(numeroDeSalas);
			consultaDisponibilidadSalasPorDia(fechaReal);
			gridHorarios();
			dibujaGrids(numeroDeSalas,fechaReal);
			primeraConsulta="false";
		}
		else{
			consultaDisponibilidadSalasPorDia(fechaReal);

			for (i=0;i<numeroDeSalas;i++){
				salaId = identiSala[i];
				jQuery("#gridSalasPJENA"+salaId).jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarDisponibilidadDeUnaSalaPorDia.do?posSala='+salaId+'',datatype: "xml" });
				$("#gridSalasPJENA"+salaId).trigger("reloadGrid");
			}
		}
	}


	/**
	*Funcion para obtener el numero de salas disponibles
	*/
	function obtenerNumeroDeSalas(){

		//numeroDeSalas=0;

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarNumeroDeSalas.do',
			data: '',
			dataType: 'xml',
			async: false,
			success: function(xml){
				$(xml).find('ListaSalas').find('Sala').each(function(){
					identiSala[numeroDeSalas] = $(this).find('salaAudienciaId').first().text();
					nombreSalas[numeroDeSalas] = $(this).find('nombreSala').first().text();
					numeroDeSalas++;
				});
			}
		});
		return numeroDeSalas;
	}

	/**
	*Funcion que inserta las tablas en HTML,donde
	*se dibujaran los grids de las salas
	*/
	function insertaTablas(numeroDeSalas){

		var indice;

		$('#gridsTd').append('<tr>');
		$('#gridsTd').append('<td><table width="100%" id="gridHorarios" border="0"></table></td>');
		for (indice=0;indice<numeroDeSalas;indice++){
			salaId = identiSala[indice];
			$('#gridsTd').append('<td><table width="100%" id="gridSalasPJENA'+salaId+'" border="0"></table></td>');
		}
		$('#gridsTd').append('</tr>');
	}


	/**
	*EnableIT By Asdrubal Funcion para obtener el nombre de sala seleccionada
	*/

	function obtenerNombreDeSalas(idSalaSeleccionada){
		var indice;
		for (indice=0;indice<numeroDeSalas;indice++){
			if (identiSala[indice]==idSalaSeleccionada){
				return indice;
			}
		}
	}
	
	
	/**
	*Funcion que consulta la disponibilidad de las salas por dia
	*/
	function consultaDisponibilidadSalasPorDia(fechaReal){

		var mesDisponible = $('#mes').val();
		var anioDisponible = $('#anio').val();

		//Recuperamos la informacion de las salas
		$.ajax({
			type: 'POST',
			url: '<%=request.getContextPath()%>/consultarDisponibilidadDeSalasPorDia.do?diaDisp='+fechaReal+'&mesDisp='+mesDisponible+'&anioDisp='+anioDisponible+'',
			data: '',
			dataType: 'xml',
			async: false,
			success: function(xml){
			}
		});
	}


	/**
	*Funcion que genera el grid con la lista de horarios
	*/
	function gridHorarios(){

		jQuery("#gridHorarios").jqGrid({

			url:'local',
			datatype: "xml",
			colNames:['Horario'],
			colModel:[{name:'hora',index:'hora', width:100, align:"center"},
					],
			pager: jQuery('#pagerHora'),
			rowNum:28,
			rowList:[10,20,30],
			autowidth: false,
			height:630,
			scrollOffset:0,
			sortname: 'hora'
		}).navGrid('#pagerHora',{edit:false,add:false,del:false});

		var mydata = [
						{hora:"09:00-09:30"},
						{hora:"09:30-10:00"},
						{hora:"10:00-10:30"},
						{hora:"10:30-11:00"},
						{hora:"11:00-11:30"},
						{hora:"11:30-12:00"},
						{hora:"12:00-12:30"},
						{hora:"12:30-13:00"},
						{hora:"13:00-13:30"},
						{hora:"13:30-14:00"},
						{hora:"14:00-14:30"},
						{hora:"14:30-15:00"},
						{hora:"15:00-15:30"},
						{hora:"15:30-16:00"},
						{hora:"16:00-16:30"},
						{hora:"16:30-17:00"},
						{hora:"17:00-17:30"},
						{hora:"17:30-18:00"},
						{hora:"18:00-18:30"},
						{hora:"18:30-19:00"},
						{hora:"19:00-19:30"},
						{hora:"19:30-20:00"},
						{hora:"20:00-20:30"},
						{hora:"20:30-21:00"},
						{hora:"21:00-21:30"},
						{hora:"21:30-22:00"},
						{hora:"22:00-22:30"},
						{hora:"22:30-23:00"}
						];
		for(var i=0;i<=mydata.length;i++)
			jQuery("#gridHorarios").jqGrid('addRowData',i+1,mydata[i]);

		//Quita el espacio entre grids
		$("#gbox_gridHorarios").css('width','87px');

	}


	/**
	*Funcion que dibuja los grids dentro de las tablas, por cada grid, se ejecuta una peticion
	*,para llenar cada grid se obtienen los valores de la consulta de disponibilidaDeSalasPorDia
	* y la peticion:/consultarDisponibilidadDeUnaSalaPorDia.do?posSala='+numSala+'' obtiene le
	* informacion para cada sala en especifico
	*/
	function dibujaGrids(numeroDeSalas,fechaReal){

		var numSala=0;

		//Dibujamos tantos grids como numero de salas
		for (numSala=0;numSala<numeroDeSalas;numSala++){

			salaId = identiSala[numSala];

			jQuery("#gridSalasPJENA"+salaId).jqGrid({
				url:'<%=request.getContextPath()%>/consultarDisponibilidadDeUnaSalaPorDia.do?posSala='+salaId+'',
				datatype: "xml",
				colNames:[nombreSalas[numSala]],
				colModel:[
							{name:'sala',index:'sala', width:100, align:"right"},
						],
				pager: jQuery('#pager'),
				rowNum:28,
				rowList:[10,20,30],
				autowidth: false,
				height:630,
				sortname: 'sala',
				scrollOffset:0,
				cellEdit: true,
				onSelectCell: function(idRow) {
							programaHorarioSala(idRow,fechaReal);
						},
				loadComplete: function(){

					$("#ocupado1").find("td").css('border','1px solid black');
					$("#ocupado1").find("td").css('padding','0 0 0 0');
					$("#ocupado1").find("td").css('background-color','#09F');



					$("#ocupadoInicio").find("td").css('border-bottom','1px solid #09F');
					$("#ocupadoInicio").find("td").css('border-left','1px solid black');
					$("#ocupadoInicio").find("td").css('border-right','1px solid black');
					$("#ocupadoInicio").find("td").css('border-top','1px solid black');
					$("#ocupadoInicio").find("td").css('padding','0 0 0 0');
					$("#ocupadoInicio").find("td").css('background-color','#09F');


					$("#ocupadoIntermedio").find("td").css('border-bottom','1px solid #09F');
					$("#ocupadoIntermedio").find("td").css('border-left','1px solid black');
					$("#ocupadoIntermedio").find("td").css('border-right','1px solid black');
					$("#ocupadoIntermedio").find("td").css('border-top','1px solid #09F');
					$("#ocupadoIntermedio").find("td").css('padding','0 0 0 0');
					$("#ocupadoIntermedio").find("td").css('background-color','#09F');


					$("#ocupadoUltimo").find("td").css('border-bottom','1px solid black');
					$("#ocupadoUltimo").find("td").css('border-left','1px solid black');
					$("#ocupadoUltimo").find("td").css('border-right','1px solid black');
					$("#ocupadoUltimo").find("td").css('border-top','1px solid #09F');
					$("#ocupadoUltimo").find("td").css('padding','0 0 0 0');
					$("#ocupadoUltimo").find("td").css('background-color','#09F');
				}
			}).navGrid('#pager',{edit:false,add:false,del:false});

			//Quita el espacio entre grids
			$("#gbox_gridSalasPJENA"+salaId).css('width','87px');
		}
	}
	//TERMINA FUNCIONALIDAD PARA LOS GIRDS DINAMICOS DE SALAS


	//COMIENZA FUNCIONES PARA ASIGNAR AUDIENCIA A UNA SALA
	/**
	*Funcion que controla el horario y la sala seleccionada, descompone la string
	*para obtener los parametros del id de la sala, la hora de inicio de cada espacio
	*y el numero de medias hrs. disponibles para ese espacio libre
	*/

	function programaHorarioSala(idRow,fechaReal){


		//verifica si la sub string ocupado se encuentra en la cadena fecha
		//de NO ser asi, devulve -1
		if(idRow.indexOf("ocupado")==-1){

			//id de la sala
			var idSalaPos1=idRow.indexOf("+", 0);
			idSalaSeleccionada=idRow.substring(0,idSalaPos1);

//	 		EnableIT By Asdrubal se agregan variables para recuperar el nombre de la sala seleccionada
			var indiceSala = obtenerNombreDeSalas(idSalaSeleccionada);
			SalaName = nombreSalas[indiceSala];
			
			//hora de inicio del espacio
			var horaInicioPos1=idRow.indexOf("+",0);
			var horaInicioPos2=idRow.indexOf("/",horaInicioPos1);
			var horaInicio=idRow.substring(horaInicioPos1+1,horaInicioPos2);


			//tama�o en medias hrs. del espacio disponible
			var espacioPos1=idRow.indexOf("/",0);
			var espacioPos2=idRow.indexOf("*",espacioPos2);
			var espacioDisponible=idRow.substring(espacioPos1+1,espacioPos2);


			//hora de inicio de la celda seleccionada
			var horaSeleccionadaPos1=idRow.indexOf("*",0);
			var horaSeleccionadaPos2=idRow.indexOf(":",horaSeleccionadaPos1);
			horaSeleccionada=idRow.substring(horaSeleccionadaPos1+1,horaSeleccionadaPos2);


			//Minuto de inicio de la celda seleccionada
			var minutoSeleccionadoPos1=idRow.indexOf(":",0);
			var minutoSeleccionadoPos2=idRow.indexOf("#",minutoSeleccionadoPos1);
			minutoSeleccionado=idRow.substring(minutoSeleccionadoPos1+1,minutoSeleccionadoPos2);


			var disponibilidad=parseInt("espacioDisponible");
			duracionEstimadaAudiencia = $("#duracionEstimadaProgramarAudiencia option:selected").val();

			/*Enable IT eliminando validacion para poder agendar a cualquier hora sin tomar en cuenta la hora del servidor*/
			if(duracionEstimadaAudiencia > 0 ){
				/* if(	validaHoraAudienciaHoraActual( horaSeleccionada, minutoSeleccionado)){ */
					if((duracionEstimadaAudiencia/30) <= espacioDisponible){
						muestraHoraSalaSeleccionada();
						deshabilitarHabilitarComponentes("horarioSala");
					}
					else{
						alertDinamico("La duraci�n estimada es mayor que el tiempo disponible para esta sala.\rIntente con otra sala");
					}
				/* }
				else{
					alertDinamico("Esta seleccionando una hora no disponible");
				} */
			}
			else{

				alertDinamico("Seleccione una duraci�n estimada para la audiencia");
			}

		}
		else{
			alertDinamico("La sala se encuentra reservada en ese horario");
		}
	}


	/**
	*funcion que muestra en el txtField correspondiente el id de la sala seleccionada
	*y la hora de inicio seleccionada
	*/
	function muestraHoraSalaSeleccionada(){

		$('#txtSalaSeleccionada').val(SalaName);
		$('#txtHoraInicioSeleccionada').val(horaSeleccionada+":"+minutoSeleccionado);
	}


	/**
	*Funcion que sonsulta la lista de jueces disponibles en base a la
	*hora y la fecha de la audiencia
	*/
	function controlJueces(automatico){

		var mesDisponible = $('#mes').val();
		var anioDisponible = $('#anio').val();
		duracionEstimadaAudiencia = $("#duracionEstimadaProgramarAudiencia option:selected").val();
		juezSustituto =  $("#juezSustituto").is(':checked');
		if(duracionEstimadaAudiencia == "" || duracionEstimadaAudiencia <= 0){
			alertDinamico("Seleccione una duraci�n estimada para la audiencia");
			return false;
		}


		if(primeraConsultaJueces=="true"){

			//Se llena el gird de jueces
			jQuery("#gridSolicitudDeAudienciaJuecesPJENA").jqGrid({
				url:'<%= request.getContextPath()%>/consultarDisponibilidadJueces.do?audienciaId='+idAudienciaSiguiente+'&diaDisp='+fechaReal+'&mesDisp='+mesDisponible+'&anioDisp='+anioDisponible+'&horaSeleccionada='+horaSeleccionada+'&minutoSeleccionado='+minutoSeleccionado+'&duracionEstimada='+duracionEstimadaAudiencia+'&automatico='+automatico+'&juezSustituto='+juezSustituto+'&tipoAudiencia='+tipoAudiencia + '&tipoDeAudienciaSolicitada=' + $("#tipoAudienciaProgramarAudiencia").val(),
				datatype: "xml",
				colNames:['Nombre','Carga de trabajo','Paridad',],
				colModel:[ 	{name:'nombre',index:'nombre', width:100, align:"center"},
				           	{name:'carga',index:'carga', width:150, align:"center"},
							{name:'paridad',index:'paridad', width:50, align:"center"},

						],
				pager: jQuery('#divGridSolicitudDeAudienciaJuecesPJENA'),
				rowNum:10,
				loadComplete: function(){
					if(automatico== true)
						//Deshabilita el multi select
						jQuery("#gridSolicitudDeAudienciaJuecesPJENA").setGridParam({multiselect:false}).hideCol('cb');
					},
				rowList:[10,20,30],
				autowidth: false,
				sortname: 'carga',
				viewrecords: true,
				sortorder: "desc",
				multiselect: true
			}).navGrid('#gridSolicitudDeAudienciaJuecesPJENA',{edit:false,add:false,del:false});

			primeraConsultaJueces="false";
			deshabilitarHabilitarComponentes("juez");
			verificarTipoAudiencia(automatico);
		}
		else{
			jQuery("#gridSolicitudDeAudienciaJuecesPJENA").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarDisponibilidadJueces.do?audienciaId='+idAudienciaSiguiente+'&diaDisp='+fechaReal+'&mesDisp='+mesDisponible+'&anioDisp='+anioDisponible+'&horaSeleccionada='+horaSeleccionada+'&minutoSeleccionado='+minutoSeleccionado+'&duracionEstimada='+duracionEstimada+'&automatico='+automatico+'&juezSustituto='+juezSustituto+'&tipoAudiencia='+tipoAudiencia + '&tipoDeAudienciaSolicitada=' + $("#tipoAudienciaProgramarAudiencia").val(),datatype: "xml" });
			$("#gridSolicitudDeAudienciaJuecesPJENA").trigger("reloadGrid");
			deshabilitarHabilitarComponentes("juez");
			verificarTipoAudiencia(automatico);
		}

	}
	//TERMINAN FUNCIONES PARA ASIGNAR AUDIENCIA A UNA SALA


	///COMIENZA FUNCIONALIDAD SALA TEMPORAL
	function asignarSalaTemporal(recuperaDatosAsignacionTemporal){

		datosSalaTemporal = recuperaDatosAsignacionTemporal;
		salaTemporal = "true";

		hrSelecTemp = datosSalaTemporal.split("=")[4];
		var hrSeleccionadaPos1=hrSelecTemp.indexOf("&", 0);
		hora=hrSelecTemp.substring(0,hrSeleccionadaPos1);
		minuto = datosSalaTemporal.split("=")[5];

		horaSeleccionada="";
		horaSeleccionada= hora;
		minutoSeleccionado="";
		minutoSeleccionado= minuto;
		cerrarVentanaAsignacionTemporal();

		$('#txtSalaSeleccionada').val(datosSalaTemporal.split("=")[2].split("&")[0]);
		$('#txtHoraInicioSeleccionada').val(horaSeleccionada+":"+minutoSeleccionado);


		deshabilitarHabilitarComponentes("designarSala");
		$('#duracionEstimadaProgramarAudiencia').multiselect('enable');

	}


	/*
	*Funcion que abre la ventana para asignar una sala temporal
	*/
	function mostrarAsignarSalaTemporalPJENA(){
		$.newWindow({id:"iframewindowAsignarSalaTemporalAudiencia" , statusBar: true, posx:250,posy:40,width:650,height:200,title:"Designaci&oacute;n de Sala Temporal de Audiencia", type:"iframe"});
	    $.updateWindowContent("iframewindowAsignarSalaTemporalAudiencia" ,'<iframe src="<%= request.getContextPath() %>/asignarSalaTemporalPJENA.do?idEvento=idAudienciaSiguiente" width="650" height="200" />');
	    banderaSalaTemp=true;
	    $('#btnDesignar').attr('disabled',true);
	}


	function cerrarVentanaAsignacionTemporal(){
		$.closeWindow('iframewindowAsignarSalaTemporalAudiencia');
	}
	//TERMINA FUNCIONALIDAD SALA TEMPORAL


	/**
	*Funcion para el guardado de la audiencia
	*/
	function guardarAudiencia(){

		var valor = jQuery("#gridSolicitudDeAudienciaJuecesPJENA").jqGrid('getGridParam','selarrrow').length;

		tipoDeAudienciaSelecc=$("#tipoAudienciaProgramarAudiencia option:selected").val();
		//Se verifica que se seleccione un tipo de audiencia
		if(tipoDeAudienciaSelecc != "0"){
			if(valor == multiselect){

				if(idAudienciaSiguiente == 0){
				recuperaIdSiguienteAudiencia();
				}

				var parametrosGuardado='';

				parametrosGuardado += 'numCarpetaEjecucion='+ $("#numExpPJENS").val();
				//parametrosGuardado += 'folioSolicitud='+ $("#numExpPJENS").val();
				parametrosGuardado += '&idAudiencia='+ idAudienciaSiguiente;
				parametrosGuardado += '&anioEvento=' + $('#anio').val();
				parametrosGuardado += '&mesEvento=' + $('#mes').val();
				parametrosGuardado += '&diaEvento=' + fechaReal;
				parametrosGuardado += '&horaEvento=' + horaSeleccionada;
				parametrosGuardado += '&minutoEvento=' + minutoSeleccionado;
				parametrosGuardado += '&duracionEstimada=' + duracionEstimadaAudiencia;
				parametrosGuardado += '&idSala=' + idSalaSeleccionada;
				parametrosGuardado += '&salaTemporal=' + salaTemporal;
				parametrosGuardado += '&tipoDeAudienciaSeleccionada='+tipoDeAudienciaSelecc;
				//eNABLE IT -INICIO- By Asdrubal
				parametrosGuardado += '&idAudienciaPasada='+idEvento;
				parametrosGuardado += '&idNumeroExpediente=' + idNumeroExpediente;
				//eNABLE IT -FIN- By Asdrubal

				//Si la asignacion de jueces fue automatica
				if(multiselect == 0){
					parametrosGuardado += '&idJueces=' + jQuery("#gridSolicitudDeAudienciaJuecesPJENA").getDataIDs();
				}
				else{
					parametrosGuardado += '&idJueces=' + jQuery("#gridSolicitudDeAudienciaJuecesPJENA").jqGrid('getGridParam','selarrrow');
				}

				var lstImputados = new Array();
				lstImputados = jQuery("#gridsImputadosAudiencia").jqGrid('getGridParam','selarrrow');

				if(lstImputados.length > 0){

					parametrosGuardado += '&idInvolucradosPA=' + jQuery("#gridsImputadosAudiencia").jqGrid('getGridParam','selarrrow');
					parametrosGuardado += '&'+datosSalaTemporal;

					parametrosGuardado += '&numeroExpediente='+numeroExpediente;
					$.ajax({
						type: 'POST',
						url: '<%= request.getContextPath()%>/guardarAudienciaProgramaNueva.do',
						data: parametrosGuardado,
						dataType: 'xml',
						async: false,
						success: function(xml){

								var mensaje = $(xml).find('body').find('horaActual').text();

								if(mensaje == "fail"){
									alertDinamico("La audiencia ya fue programada anteriormente");
									/*
									*recargamos el grid de audiencias para que la solicitud de audiencia que se abr�o ya no
									*aparesca en la bandeja
									*/
									parent.cargaGridDiaPJENS();

								}
								else if(mensaje == "salaOcupada"){
									alertDinamico("Otro usuario acaba de programar una audiencia en esta sala y horario");
									try{
										parent.cargaGridDiaPJENS();
										setTimeout("recargaVisor()",3000);
									}catch(e){}

								}
								else{
							alertDinamico("La programaci�n de la audiencia se realiz� de manera correcta");
								/*
								*recargamos el grid de audiencias para que la audiencia que se acaba de
								*programar, no se muestre mas
								*/
								parent.cargaGridDiaPJENS();
								//deshabilitamos el boton de guardado
								$('#btnGuardarAudiencia').attr('disabled',true);
								//Refrescamos el grid de las salas
								controlSalas(fechaReal);
								//Mostramos las cejas para capturar
								muestraSubCejasProgAudiencia();
								//Carga Grid denunciante y victima
								cargaGridVictima1();
								cargaGridDenunciante1();
								//Carga gird de imputados que se arrastraron a la audiencia
								cargaGridImputado1();
								//recarga el grid de imputados
								cargaImputadosProgramarAudiencia(idAudiencia);
								//Recarga grid de involucrados a la siguiente audiencia
								cargaGridPolicia1();
								cargaGridPerito1();
								cargaGridTestigo1();
								//////////////////////////
								cargaGridFiscal1();
								cargaGridDefensor1();
								}
						}
					});

				}
				else{
					alertDinamico("Seleccione por lo menos un imputado para la siguiente audiencia");
				}

			}else{
				if(multiselect==1){
					alertDinamico('Seleccione exactamente un juez del listado');
				}
				else{
					alertDinamico('Seleccione exactamente '+multiselect+' jueces del listado');
				}
			}
		}
		else{
			alertDinamico('Seleccione un tipo de audiencia a programar');
		}
	}

	/*Funcion que permite refrescar la ventana y redirigirla de nuevo*/
	function recargaVisor(){
			document.frmRecargaVisor.idAudiencia.value = idAudiencia;
			document.frmRecargaVisor.idVisor.value = 2;
			document.frmRecargaVisor.idAudienciaSiguiente.value = idAudienciaSiguiente;
			document.frmRecargaVisor.submit();
	}



	/*****FUNCIONALIDAD PARA LA SUB CEJA INVOLUCRADOS DE LA SIGUIENTE AUDIENCIA*/


	var banderaGridImputado1= true;
	/*
	*Funcion que carga el grid de Impitados para la siguiente audiencia
	*/
	function cargaGridImputado1(){

		tipoConsulta=0;

		if(banderaGridImputado1 == true){

			jQuery("#gridImputado1").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Parte','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
							{name:'APaterno',index:'APaterno', width:180,align:'center'},
							{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
							{name:'Parte',index:'Parte', width:100,align:'center',hidden:true},
							{name:'Presente',index:'Presente', width:150,align:'center',hidden:true},
						],
				autowidth: false,
				width:924,
				autoheight: true,
				pager: jQuery('#paginadorGridImputado1'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				//hiddengrid: true,
				toolbar: [true,"top"],
				caption:"Imputado"
			}).navGrid('#paginadorGridImputado1',{edit:false,add:false,del:false});


			banderaGridImputado1 = false;
		}
		else{
			jQuery("#gridImputado1").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta, datatype: "xml" });
			$("#gridImputado1").trigger("reloadGrid");
		}

	}

	/////////////////////////////////
	var banderaCargaGridVictima1 = true;
	/*
	*Funcion que carga el grid de victimas
	*/
	function cargaGridVictima1(){

		var tipoConsulta=6;

		if( banderaCargaGridVictima1 == true){

			jQuery("#gridVictima1").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
							{name:'APaterno',index:'APaterno', width:180,align:'center'},
							{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
							{name:'Presente',index:'Presente', width:50,align:'center',hidden:true},
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridVictima1'),
					sortname: 'Nombre',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					toolbar: [true,"top"],
					caption:"V�ctima",
					ondblClickRow: function(rowid) {
						//creaNuevoTestigo(rowid);
						consultarVictima1(rowid);
					}
			}).navGrid('#paginadorGridVictima1',{edit:false,add:false,del:false});

			$("#t_gridVictima1").append("<input type='button' class='btn_Generico' id='btnAgregarVictimaSig' value='Agregar nueva victima' style='height:20px;font-size:-3'/>");

			$("#btnAgregarVictimaSig","#t_gridVictima1").click(function(){
				creaNuevaVictima1();
			});

			///Se agrega boton para relacionar victimas existentes con la nueva audiencia
			$("#t_gridVictima1").append("<input type='button' class='btn_Generico' id='btnAgregarVictimaExistente' value='Agregar victima existente' style='height:20px;font-size:-3'/>");

			$("#btnAgregarVictimaExistente","#t_gridVictima1").click(function(){
				asociarInvolucradosPorCalidadAudienciaSiguiente("<%=Calidades.VICTIMA_PERSONA.getValorId()%>");
			});

			banderaCargaGridVictima1= false;
		}
		else{
			jQuery("#gridVictima1").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta , datatype: "xml" });
			$("#gridVictima1").trigger("reloadGrid");
		}
	}

	var idWindowIngresarVictima1 = 1;

	//Abre una nueva ventana de crear una nueva victima
	function creaNuevaVictima1() {
		idWindowIngresarVictima1++;
		var elementoNuevo="si";
		$.newWindow({id:"iframewindowIngresarVictima1" + idWindowIngresarVictima1, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar V�ctima", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarVictima1" + idWindowIngresarVictima1,'<iframe src="<%= request.getContextPath() %>/IngresarVictima.do?numeroExpediente='+numeroExpediente +'&audienciaId='+idAudienciaSiguiente+'&elemento='+elementoNuevo+'" width="1100" height="530" />');
	}

	var idWindowConsultarVictima1 = 1;

	//Abre una nueva ventana para consultar una v�ctima
	function consultarVictima1(idInvolucrado){
		idWindowConsultarVictima1++;
		$.newWindow({id:"iframewindowConsultarVictima1" + idWindowConsultarVictima1, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Consultar Victima", type:"iframe"});
		$.updateWindowContent("iframewindowConsultarVictima1" + idWindowConsultarVictima1,'<iframe src="<%= request.getContextPath() %>/ConsultarIndividuo.do?numeroExpediente='+numeroExpediente+'&idVictima='+idInvolucrado+'&idCalidad=VICTIMA" width="1100" height="530" />');
	}


	var banderaCargaGridDenunciante1 = true;

	/*
	*Funcion que carga el grid de denunciantes
	*/
	function cargaGridDenunciante1(){

		tipoConsulta=7;

		if( banderaCargaGridDenunciante1 == true){

			jQuery("#gridDenunciante1").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
							{name:'APaterno',index:'APaterno', width:180,align:'center'},
							{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
							{name:'Presente',index:'Presente', width:50,hidden:true,align:'center'},
						],
					autowidth: false,
					width:924,
					autoheight:true,
					pager: jQuery('#paginadorGridDenunciante1'),
					sortname: 'Nombre',
					rownumbers: false,
					gridview: false,
					viewrecords: true,
					sortorder: "desc",
					hiddengrid: false,
					toolbar: [true,"top"],
					caption:"Denunciante",
					ondblClickRow: function(rowid) {

						consultarDenunciante1(rowid);
					}
			}).navGrid('#paginadorGridDenunciante1',{edit:false,add:false,del:false});

			$("#t_gridDenunciante1").append("<input type='button' class='btn_Generico' id='btnAgregarDenuncianteSig' value='Agregar Denunciante' style='height:20px;font-size:-3'/>");

			$("#btnAgregarDenuncianteSig","#t_gridDenunciante1").click(function(){
				crearDenunciante1();
			});

			$("#t_gridDenunciante1").append("<input type='button' class='btn_Generico' id='btnAgregarDenuncianteExistente' value='Agregar denunciante existente' style='height:20px;font-size:-3'/>");
			$("#btnAgregarDenuncianteExistente","#t_gridDenunciante1").click(function(){
				asociarInvolucradosPorCalidadAudienciaSiguiente("<%=Calidades.DENUNCIANTE.getValorId()%>");
			});

			banderaCargaGridDenunciante1 = false;
		}
		else{
			jQuery("#gridDenunciante1").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta , datatype: "xml" });
			$("#gridDenunciante1").trigger("reloadGrid");
		}
	}


	var idWindowIngresarDenunciante1 = 1;

	//Abre una nueva ventana de Denunciante
	function crearDenunciante1(){
		idWindowIngresarDenunciante1++;
		elementoNuevo = "si";
		$.newWindow({id:"iframewindowIngresarDenunciante1" + idWindowIngresarDenunciante1, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar Denunciante", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarDenunciante1" + idWindowIngresarDenunciante1,'<iframe src="<%= request.getContextPath() %>/IngresarDenunciante.do?numeroExpediente='+numeroExpediente +'&audienciaId='+idAudienciaSiguiente+'&elemento='+elementoNuevo+'&calidadInv=DENUNCIANTE" width="1100" height="530" />');
	}

	var idWindowConsultarDenunciante1 = 1;

	//Abre una nueva ventana de Denunciante
	function consultarDenunciante1(id){
		idWindowConsultarDenunciante1++;
		$.newWindow({id:"iframewindowIngresarDenunciante1" + idWindowConsultarDenunciante1, statusBar: true, posx:75,posy:30,width:1100,height:530,title:"Ingresar Denunciante", type:"iframe"});
	    $.updateWindowContent("iframewindowIngresarDenunciante1" + idWindowConsultarDenunciante1,'<iframe src="<%= request.getContextPath() %>/IngresarDenunciante.do?idDenunciante='+id +'&numeroExpediente='+numeroExpediente +'&calidadInv=DENUNCIANTE" width="1100" height="530" />');
	}


	var banderaGridTestigo1= true;
	/*
	*Funcion que carga el grid de Testigos para la siguiente audiencia
	*/
	function cargaGridTestigo1(){

		tipoConsulta=3;

		if(banderaGridTestigo1 == true){

			jQuery("#gridTestigo1").jqGrid({

				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Presente'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
							{name:'APaterno',index:'APaterno', width:180,align:'center'},
							{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
							{name:'Presente',index:'Presente', width:150,align:'center',hidden:true},
						],
				autowidth: false,
				width:924,
				autoheight: true,
				pager: jQuery('#paginadorGridTestigo1'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				//hiddengrid: true,
				toolbar: [true,"top"],
				caption:"Testigo",
				ondblClickRow: function(rowid) {
					creaNuevoTestigoAudienciaSiguiente(rowid);
				}
			}).navGrid('#paginadorGridTestigo1',{edit:false,add:false,del:false});

			$("#t_gridTestigo1").append("<input type='button' class='btn_Generico' id='btnAgregarTestigoSig' value='Agregar Testigo' style='height:20px;font-size:-3'/>");

			$("#btnAgregarTestigoSig","#t_gridTestigo1").click(function(){
				creaNuevoTestigoAudienciaSiguiente(null);
			});

			$("#t_gridTestigo1").append("<input type='button' class='btn_Generico' id='btnAgregarTestigoExistente' value='Agregar testigo existente' style='height:20px;font-size:-3'/>");

			$("#btnAgregarTestigoExistente","#t_gridTestigo1").click(function(){
				asociarInvolucradosPorCalidadAudienciaSiguiente("<%=Calidades.TESTIGO.getValorId()%>");
			});

			banderaGridTestigo1 = false;
		}
		else{
			jQuery("#gridTestigo1").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta, datatype: "xml" });
			$("#gridTestigo1").trigger("reloadGrid");
		}

	}

	/*
	*Funcion que carga el grid para los fiscales de la siguiente audiencia
	*/
	function cargaGridFiscal1(){

		tipoConsulta=1;


		jQuery("#gridFiscal1").jqGrid({

			url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Titular','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
						{name:'APaterno',index:'APaterno', width:180,align:'center'},
						{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
						{name:'Titular',index:'Titular', width:50,align:'center',hidden:true},
						{name:'Presente',index:'Presente', width:60,align:'center',hidden:true}
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridFiscal1'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				loadComplete: function(){
					primeraFiscal="false";
				},
				caption:"Fiscal"
		}).navGrid('#paginadorGridFiscal',{edit:false,add:false,del:false});

		$("#t_gridFiscal1").append("<input type='button' class='btn_Generico' id='butAgreAmp1' value='Agregar Amp' style='height:20px;font-size:-3'/>");

		//Button eliminar amp
		$("#t_gridFiscal1").append("<input type='button' class='btn_Generico' id='butElimAmp1' value='Eliminar Amp' style='height:20px;font-size:-3'/>");


		$("#butAgreAmp1","#t_gridFiscal1").click(function(){
			puestoFuncionarioSig="amp";
			agregarFuncionarioSig();
		});

		$("#butElimAmp1","#t_gridFiscal1").click(function(){
			puestoFuncionarioSig="amp";
			var rowid = jQuery("#gridFiscal1").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudienciaSig(rowid);
		});


	}


	/*
	*Funcion que carga el grid para los peritos de la siguiente audiencia
	*/
	function cargaGridPerito1(){

		tipoConsulta=4;

		jQuery("#gridPerito1").jqGrid({

			url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Parte','Especialidad','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
						{name:'APaterno',index:'APaterno', width:180,align:'center'},
						{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
						{name:'Parte',index:'Parte', width:100,hidden:true},
						{name:'Parentesco',index:'Parentesco', width:150,hidden:true},
						{name:'Titular',index:'Titular', width:150,hidden:true},
					],
			autowidth: false,
			width:924,
			autoheight: true,
			pager: jQuery('#paginadorGridPerito1'),
			sortname: 'Nombre',
			rownumbers: false,
			gridview: false,
			viewrecords: true,
			sortorder: "desc",
			//hiddengrid: true,
			toolbar: [true,"top"],
			caption:"Perito"
		}).navGrid('#paginadorGridPerito1',{edit:false,add:false,del:false});

		$("#t_gridPerito1").append("<input type='button' class='btn_Generico' id='butAgrePer1' value='Agregar Perito' style='height:20px;font-size:-3'/>");

		//Button eliminar perito
		$("#t_gridPerito1").append("<input type='button' class='btn_Generico' id='butElimPer1' value='Eliminar Perito' style='height:20px;font-size:-3'/>");

		$("#butAgrePer1","#t_gridPerito1").click(function(){
			puestoFuncionarioSig="perito";
			agregarFuncionarioSig();
		});

		$("#butElimPer1","#t_gridPerito1").click(function(){
			puestoFuncionarioSig="perito";
			var rowid = jQuery("#gridPerito1").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudienciaSig(rowid);
		});
	}

	/*
	*Funcion que carga el grid para los policias ministeriales de la siguiente audiencia
	*/
	function cargaGridPolicia1(){

		tipoConsulta=5;

		jQuery("#gridPolicia1").jqGrid({

			url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Parte','Aceptado'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:150,align:'center'},
						{name:'APaterno',index:'APaterno', width:100,align:'center'},
						{name:'AMaterno',index:'AMaterno', width:150,align:'center'},
						{name:'Parte',index:'Parte', width:150,hidden:true},
						{name:'Aceptado',index:'Aceptado', width:150,hidden:true},

					],
			autowidth: false,
			width:924,
			autoheight: true,
			pager: jQuery('#paginadorGridPolicia1'),
			sortname: 'Nombre',
			rownumbers: false,
			gridview: false,
			viewrecords: true,
			sortorder: "desc",
			//hiddengrid: false,
			toolbar: [true,"top"],
			caption:"Elemento de la polic�a ministerial"
		}).navGrid('#paginadorGridPolicia1',{edit:false,add:false,del:false});

		$("#t_gridPolicia1").append("<input type='button' class='btn_Generico' id='butAgrePolMin1' value='Agregar Policia Ministerial' style='height:20px;font-size:-3'/>");

		//Button eliminar amp
		$("#t_gridPolicia1").append("<input type='button' class='btn_Generico' id='butElimPolMin1' value='Eliminar Policia Ministerial' style='height:20px;font-size:-3'/>");

		$("#butAgrePolMin1","#t_gridPolicia1").click(function(){
			puestoFuncionarioSig="policia";
			agregarFuncionarioSig();
		});

		$("#butElimPolMin1","#t_gridPolicia1").click(function(){
			puestoFuncionarioSig="policia";
			var rowid = jQuery("#gridPolicia1").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudienciaSig(rowid);
		});
	}


	/*
	*Funcion que carga el grid de defensores de la sub tab, para la siguiente audiencia
	*/
	function cargaGridDefensor1(){

		tipoConsulta=2;

		jQuery("#gridDefensor1").jqGrid({

			url:'<%= request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,
			datatype: "xml",
			colNames:['Nombre','Apellido Paterno', 'Apellido Materno','Titular','Presente'],
			colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
						{name:'APaterno',index:'APaterno', width:180,align:'center'},
						{name:'AMaterno',index:'AMaterno', width:180,align:'center'},
						{name:'Titular',index:'Titular', width:50,align:'center',hidden:true},
						{name:'Presente',index:'Presente', width:60,align:'center',hidden:true}
					],
				autowidth: false,
				width:924,
				autoheight:true,
				pager: jQuery('#paginadorGridDefensor1'),
				sortname: 'Nombre',
				rownumbers: false,
				gridview: false,
				viewrecords: true,
				sortorder: "desc",
				hiddengrid: false,
				toolbar: [true,"top"],
				caption:"Defensor"
		}).navGrid('#paginadorGridDefensor1',{edit:false,add:false,del:false});

		$("#t_gridDefensor1").append("<input type='button' class='btn_Generico' id='butADefensor1' value='Agregar Defensor' style='height:20px;font-size:-3'/>");

		$("#t_gridDefensor1").append("<input type='button' class='btn_Generico' id='butElimDefensor1' value='Eliminar Defensor' style='height:20px;font-size:-3'/>");

		$("#t_gridDefensor1").append("<input type='button' class='btn_Generico' id='butSDefensor1' value='Solicitar Defensor' style='height:20px;font-size:-3'/>");

		$("#butADefensor1","#t_gridDefensor1").click(function(){
			puestoFuncionarioSig="defensor";
			agregarFuncionarioSig();
		});

		$("#butElimDefensor1","#t_gridDefensor1").click(function(){
			puestoFuncionarioSig="defensor";
			var rowid = jQuery("#gridDefensor1").jqGrid('getGridParam','selrow');
			eliminarFuncionarioAudienciaSig(rowid);
		});

		$("#butSDefensor1","#t_gridDefensor1").click(function(){
			solicitarDefensor();
		});
	}


	//FUNCIONALIDAD PARA AGREGAR FUNCIONARIO PARA LA SIGUIENTE AUDIENCIA
	/**
	*Funcion que abre la ventana modal para introducir un funcionario
	*/
	function agregarFuncionarioSig(){

		limpiaVentanaIngresarFuncionarioSig();
		habilitarCamposSig();
		cargaComboFuncionariosSig();
		$("#divIngresarFuncionarioSig").dialog("open");
	  	$("#divIngresarFuncionarioSig").dialog({ autoOpen: true,
		modal: true,
	  	title: 'Agregar funcionario a la siguiente audiencia',
	  	dialogClass: 'alert',
	  	position: [400,220],
	  	width: 450,
	  	height: 300,
	  	maxWidth: 450,
		maxHeight: 300,
		minWidth: 450,
		minHeight: 300,
	  	buttons:{"Aceptar":function() {
	  			var selected = $("#cbxFuncionarioSigPJENS option:selected").val();
		  		if(selected == 0){
		  			if(validarDatosFuncionarioSig() == true){
			  			guardarFuncionarioSig();
			  			$(this).dialog("close");
				  	}
			  	}
		  		else{
		  			guardarFuncionarioSig();
		  			$(this).dialog("close");
			  	}
		  	},
			"Cancelar" : function() {
				$(this).dialog("close");
			}
		  }
		});
	}

	/*
	*Funcion para eliminar la relacion entre un funcionario y la audiencia
	*/
	function eliminarFuncionarioAudienciaSig(claveFuncionarioSig){

		if (claveFuncionarioSig){

			var parametrosEliminarSig='';

			parametrosEliminarSig += 'claveFuncionario='+ claveFuncionarioSig;
			parametrosEliminarSig += '&idAudiencia=' + idAudienciaSiguiente;

			$.ajax({
				type: 'POST',
				url: '<%= request.getContextPath()%>/eliminarFuncionarioAudiencia.do',
				data: parametrosEliminarSig,
				dataType: 'xml',
				async: false,
				success: function(xml){

					var errorCode=$(xml).find('response').find('code').text();

					if(parseInt(errorCode)==0){

						respuesta = $(xml).find('String').text();

						if(respuesta == "ok"){
							alertDinamico("Funcionario eliminado con �xito");
							recargaGridsSig();
						}else{
							alertDinamico("El funcionario no pudo ser eliminado");
						}
	    			}
					else{
						//Error
					}
				}
			});
		}
		else{
			alertDinamico("Seleccione un funcionario");
		}
	}



	/*
	*Funcion que relaciona los involucrado a la audiencia actual
	*/
	function asociarInvolucradosPorCalidadAudienciaSiguiente(calidadId){

		cargaGridRelacionarInvolucradosPorCalidadAudienciaSig(calidadId);

		$("#divRelacionarInvolucradosPorCalidadAudienciaSig").dialog("open");
		$("#divRelacionarInvolucradosPorCalidadAudienciaSig").dialog({ autoOpen: true, modal: true,
		title: 'Asociar involucrados a la siguiente audiencia',
		dialogClass: 'alert', position: [350,50],
		width: 800, height:480, maxWidth: 800, maxHeight:550,
		buttons:{
			"Asociar":function() {
				customConfirm("�Realmente desea asociar los involucrados a la siguiente audiencia?", "", asociarIndividuoAAudiencia);
			},
			"Cancelar":function() {
				cerrarAsociarInvolucradosPorCalidadAudienciaSiguiente();
			}
		}
		});

	}

	/**
	*Cierra el dialog confirm
	*/
	function cerrarAsociarInvolucradosPorCalidadAudienciaSiguiente(){
		$("#divRelacionarInvolucradosPorCalidadAudienciaSig").dialog("close");
	}

	//Variable para controlar si se carga por primera vez el grid
	var banderaRelacionarInvolucradosPorCalidadAudienciaSig = true;

	/**
	*Funcion que carga el grid medios de Prueba
	*/
	function cargaGridRelacionarInvolucradosPorCalidadAudienciaSig(calidadId){

		var tipoConsulta= "";

		if(calidadId == "<%=Calidades.VICTIMA_PERSONA.getValorId()%>"){
			tipoConsulta=TIPO_CONSULTA_VICTIMA;
		}
		if(calidadId == "<%=Calidades.DENUNCIANTE.getValorId()%>"){
			tipoConsulta=TIPO_CONSULTA_DENUNCIANTE;
		}
		if(calidadId == "<%=Calidades.TESTIGO.getValorId()%>"){
			tipoConsulta=TIPO_CONSULTA_TESTIGO;
		}

		if(banderaRelacionarInvolucradosPorCalidadAudienciaSig == true){

			jQuery("#gridRelacionarInvolucradosPorCalidadAudienciaSig").jqGrid({
				url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta,
				datatype: "xml",
				colNames:['Nombre','Apellido Paterno', 'Apellido Materno'],
				colModel:[ 	{name:'Nombre',index:'Nombre', width:180,align:'center'},
							{name:'APaterno',index:'APaterno', width:180,align:'center'},
							{name:'AMaterno',index:'AMaterno', width:180,align:'center'}
						],
				pager: jQuery('#pagerGridRelacionarInvolucradosPorCalidadAudienciaSig'),
				rowNum:10,
				autoWidth:false,
				width:580,
				height:250,
				rowList:[10,20,30],
				sortname: 'Nombre',
				viewrecords: true,
				sortorder: "desc",
				caption:"Involucrados a relacionar",
				multiselect:true
			}).navGrid('#gridRelacionarInvolucradosPorCalidadAudienciaSig',{edit:false,add:false,del:false});

			banderaRelacionarInvolucradosPorCalidadAudienciaSig = false;
		}
		else{
			jQuery("#gridRelacionarInvolucradosPorCalidadAudienciaSig").jqGrid('setGridParam', {url:'<%= request.getContextPath() %>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idEvento+"&tipoConsulta="+tipoConsulta , datatype: "xml" });
			$("#gridRelacionarInvolucradosPorCalidadAudienciaSig").trigger("reloadGrid");
		}
	}

	/*
	* Asocia un involucrado recien creado a la audiencia con el id enviado como parametro
	*/
	function asociarIndividuoAAudiencia(){

		var iDsInvolucrados = "";
		var exitoAsociar = 0;

		iDsInvolucrados += jQuery("#gridRelacionarInvolucradosPorCalidadAudienciaSig").jqGrid('getGridParam','selarrrow');

		if(iDsInvolucrados != ""){

			var arrayIds = iDsInvolucrados.split(",");


			for(indice=0;indice<arrayIds.length;indice++){

				$.ajax({
					type: 'POST',
			    	url: '<%= request.getContextPath()%>/asociarInvolucradoAAudiencia.do',
			    	data: 'involucradoId='+arrayIds[indice]+'&audienciaId='+idAudienciaSiguiente,
			    	async:false,
			    	dataType: 'xml',
			    	success: function(xml){
			    		exitoAsociar++;
			    	}
				});
			}

			if(parseInt(exitoAsociar) > 0 ){
				exitoAsociar = 0;
				cargaGridTestigo1();
				cargaGridDenunciante1();
				cargaGridVictima1();
				customAlert("Los involucrados fueron asociados de manera correcta");
				cerrarAsociarInvolucradosPorCalidadAudienciaSiguiente()
			}
			else{
				customAlert("No es posible asociar los involucrados");
			}

		}else{
			customAlert("Seleccione al menos un involucrado");
		}
	}


	/*
	*Funcion que dispara el Action para consultar Funcionario por tipo de especialidad
	*/
	function cargaComboFuncionariosSig(){

		limpiaComboFuncionariosSig();

		var tipoEspecialidad;

		if(puestoFuncionarioSig == "amp"){
			tipoEspecialidad=<%=TipoEspecialidad.MINISTERIO_PUBLICO.getValorId()%>;
		}
		if(puestoFuncionarioSig == "defensor"){
			tipoEspecialidad=<%=TipoEspecialidad.DEFENSOR.getValorId()%>;
		}
		if(puestoFuncionarioSig == "perito"){
			tipoEspecialidad=<%=TipoEspecialidad.PERICIAL.getValorId()%>;
		}
		if(puestoFuncionarioSig == "policia"){
			tipoEspecialidad=<%=TipoEspecialidad.POLICIA.getValorId()%>;
		}

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarCatalogoFuncionariosPorTipoEspecialidad.do',
			data:'tipoEspecialidad='+tipoEspecialidad ,
			dataType: 'xml',
			async: false,
			success: function(xml){

				$(xml).find('listaFuncionarios').find('funcionario').each(function(){
					$('#cbxFuncionarioSigPJENS').append('<option value="' + $(this).find('claveFuncionario').text() + '">'+ $(this).find('nombreFuncionario').text() + ' '+$(this).find('apellidoPaternoFuncionario').text() + ' '+$(this).find('apellidoMaternoFuncionario').text() +'</option>');
				});
			}
		});
	}


	function habilitaCamposSig(){

		var selected = $("#cbxFuncionarioSigPJENS option:selected").val();

		limpiaVentanaIngresarFuncionarioSig();
		if(selected == 0){
			$('#nombreFuncionarioSigPJENS').attr('disabled', false);
			$('#apPatFuncionarioSigPJENS').attr('disabled', false);
			$('#apMatFuncionarioSigPJENS').attr('disabled', false);
		}
		else{
			$('#nombreFuncionarioSigPJENS').attr('disabled', true);
			$('#apPatFuncionarioSigPJENS').attr('disabled', true);
			$('#apMatFuncionarioSigPJENS').attr('disabled', true);

		}
	}


	/*
	*Valida que los datos del funcionario esten completos
	*/
	function validarDatosFuncionarioSig(){

		if($('#nombreFuncionarioSigPJENS').val().trim() != "" && $('#apPatFuncionarioSigPJENS').val().trim() != ""){
			return true;
		}
		else{
			alertDinamico("Ingrese el nombre completo del funcionario");
			return false;
		}
	}

	/*
	*Funcion refresca grids
	*/
	function recargaGridsSig(){

		if(puestoFuncionarioSig == "amp"){
			tipoConsulta=1;
			jQuery("#gridFiscal1").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridFiscal1").trigger("reloadGrid");
		}
		if(puestoFuncionarioSig == "defensor"){
			tipoConsulta=2;
			jQuery("#gridDefensor1").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridDefensor1").trigger("reloadGrid");
		}
		if(puestoFuncionarioSig == "perito"){
			tipoConsulta=4;
			jQuery("#gridPerito1").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridPerito1").trigger("reloadGrid");
		}
		if(puestoFuncionarioSig == "policia"){
			tipoConsulta=5;
			jQuery("#gridPolicia1").jqGrid('setGridParam', {url:'<%=request.getContextPath()%>/consultarInvolucradosAudienciaIndividualizacion.do?idEvento='+idAudienciaSiguiente+"&tipoConsulta="+tipoConsulta,datatype: "xml" });
			$("#gridPolicia1").trigger("reloadGrid");
		}
	}

	/*
	*Funcion que agrega el enumm para la especialidad del funcionario
	*/
	function guardarFuncionarioSig(){

		var puesto;
		var tipoEspecialidad;

		if(puestoFuncionarioSig == "amp"){
			puesto=<%=Puestos.FISCAL.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.MINISTERIO_PUBLICO.getValorId()%>;
		}
		if(puestoFuncionarioSig == "defensor"){
			puesto=<%=Puestos.ABOGADO_DEFENSOR.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.DEFENSOR.getValorId()%>;
		}
		if(puestoFuncionarioSig == "perito"){
			puesto=<%=Puestos.PERITO.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.PERICIAL.getValorId()%>;
		}
		if(puestoFuncionarioSig == "policia"){
			puesto=<%=Puestos.POLICIA_MINISTERIAL.getValorId()%>;
			tipoEspecialidad=<%=TipoEspecialidad.POLICIA.getValorId()%>;
		}

		var parametrosFunc='';

		parametrosFunc += 'nombreFunc='+ $('#nombreFuncionarioSigPJENS').val().trim();
		parametrosFunc += '&apPatFunc=' + $('#apPatFuncionarioSigPJENS').val().trim();
		parametrosFunc += '&apMatFunc=' + $('#apMatFuncionarioSigPJENS').val().trim();
		parametrosFunc += '&puesto=' + puesto;
		parametrosFunc += '&tipoEspecialidad=' + tipoEspecialidad;
		parametrosFunc += '&idAudiencia=' + idAudienciaSiguiente;
		parametrosFunc += '&claveFuncionario=' + $("#cbxFuncionarioSigPJENS option:selected").val();

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/guardarFuncionarioPorNombreYPuesto.do',
			data: parametrosFunc,
			dataType: 'xml',
			async: false,
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
				if(parseInt(errorCode)==0){
					alertDinamico("Funcionario guardado con �xito");
					recargaGridsSig();
					limpiaVentanaIngresarFuncionarioSig();
					limpiaComboFuncionariosSig();
					habilitaCamposSig();
    			}
				else{
					habilitaCamposSig();
					limpiaVentanaIngresarFuncionarioSig();
					//Mostrar mensaje de error
				}
			}
		});
	}


	/*
	*Funcion que limpia los datos de la ventana modal
	*ingresar funcionario a audiencia
	*/
	function limpiaVentanaIngresarFuncionarioSig(){

		$('#nombreFuncionarioSigPJENS').val("");
		$('#apPatFuncionarioSigPJENS').val("");
		$('#apMatFuncionarioSigPJENS').val("");
	}

	/*
	*Funcion que limpia el combo de funcionarios
	*/
	function limpiaComboFuncionariosSig(){

		$('#cbxFuncionarioSigPJENS').empty();
		$('#cbxFuncionarioSigPJENS').append('<option value="0">-Seleccione-</option>');
		//Por default seleccione
	}

	/*
	*Funcion que habilita los campos de captura
	*/
	function habilitarCamposSig(){

		$('#nombreFuncionarioSigPJENS').attr('disabled', false);
		$('#apPatFuncionarioSigPJENS').attr('disabled', false);
		$('#apMatFuncionarioSigPJENS').attr('disabled', false);
	}
	//TERMINA FUNCIONALIDAD PARA AGREGAR FUNCIONARIO




	/****FUNCIONALIDAD PARA LA SUB CEJA OBJETOS*/
	/**
	*Funcion que carga el grid Objetos
	*/
	function cargaGridObjetos(){

		jQuery("#gridSolObjetos").jqGrid({
			url:'<%=request.getContextPath()%>/gridConsultaObjetos.do?audienciaId='+idAudienciaSiguiente,
			datatype: "xml",
			colNames:['Otorgante','No. Prueba', 'Cadena de Custodia', 'Descripci�n Objeto', 'Aceptado'],
			colModel:[
			           	{name:'Otorgante',index:'Otorgante', width:100, align:'center'},
			           	{name:'Prueba',index:'Prueba', width:80, align:'center'},
			           	{name:'Cadena',index:'Cadena', width:80, align:'center'},
			        	{name:'Objeto',index:'Objeto', width:100, align:'center'},
			           	{name:'Aceptado',index:'Aceptado', width:80, align:'center'},
					],
			pager: jQuery('#pagerGridSolObjetos'),
			rowNum:10,
			autoWidth:false,
			width:400,
			rowList:[10,20,30],
			sortname: 'duracion',
			viewrecords: true,
			sortorder: "desc"
		}).navGrid('#gridSolObjetos',{edit:false,add:false,del:false});

		$("#gview_gridSolObjetos .ui-jqgrid-bdiv").css('height', '150px');

	}


	/*
	*Funcion que guarda un objeto capturado en la sub ceja de objetos de la ceja Prog. Audiencia
	*/
	function guardaObjeto(){

		var param="idAudiencia="+idAudienciaSiguiente;
		param+="&campoObjeto="+$("#campoObjeto").val();
		param+="&campoPrueba="+$("#campoPrueba").val();
		param+="&campoCadena="+$("#campoCadena").val();
		param+="&campoDescripciona="+$("#campoDescripciona").val();
		param+="&campoEstado="+$("#campoEstado option:selected").val();
		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/guardaObjetosCarpetaEjecucion.do',
			data: param,
			async: false,
			dataType: 'xml',
			success: function(xml){

			}
		});
		$("#gridSolObjetos").trigger("reloadGrid");
	}

	/*
	*Funcion que carga el catalogo de condicion fisica del objeto
	*/
	function cargaCondicion() {
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarCondicion.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catCondicion').each(function(){
					$('#campoEstado').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}


/*************************************************************FUNCIONALIDAD PARA LA CEJA ADMINISTRAR ACTUACIONES DE AUDIENCIA*************************************/

	/*
  	* Funcion para llamar la funcion de habilitar los elementos de la pantalla
  	*/
  	function onSelectChangeTipo() {
    	var selected = $("#finalAudienciaOpcion option:selected");
  		enableControls(selected.val());
  	}

	/*
	*Funcion que habilita o deshabilita los elementos de la pagina dependiento del tipo
	* de busqueda
	*/
	function enableControls(tipo){

		$("#divGernerarActa").hide();
		$("#divSolicitarCopia").hide();
		$("#divSolicitarTranscripcion").hide();
		$("#divSolicitarTraslado").hide();

		numExp = $("#numExpPJENS").val();

  		if (parseInt(tipo) == 1){
  			//limpiaCampos();
  			$("#divGernerarActa").show();

  				$.newWindow({id:"iframewindowGenerarActaAudiencia", statusBar: true, posx:200,posy:50,width:1140,height:400,title:"Generar Acta de Audiencia", type:"iframe"});
  			    $.updateWindowContent("iframewindowGenerarActaAudiencia",'<iframe src="<%= request.getContextPath() %>/generarDocumentoSinCaso.do?numeroUnicoExpediente='+numExp+'&formaId=<%=mx.gob.segob.nsjp.comun.enums.forma.Formas.AUDIENCIA.getValorId() %>&esconderArbol=1&idAudiencia='+idAudiencia+'" width="1140" height="400" />');

  		}
	  		else{if (parseInt(tipo) == 2){
	  			//limpiaCampos();
				$("#divSolicitarCopia").show();
				registraSolicitud(<%= TiposSolicitudes.AUDIO_VIDEO.getValorId() %>);
	  		}
				else{if (parseInt(tipo) == 3){
						//limpiaCampos();
						$("#divSolicitarTranscripcion").show();
						registraSolicitud(<%= TiposSolicitudes.TRANSCRIPCION_DE_AUDIENCIA.getValorId() %>);
					}

				   	else{if (parseInt(tipo) == 4){
				   	//limpiaCampos();
				    	$("#divSolicitarTraslado").show();
				    	//$.newWindow({id:"iframewindowGenerarDocumento", statusBar: true, posx:200,posy:50,width:1140,height:400,title:"Generar Documento", type:"iframe"});
							    //$.updateWindowContent("iframewindowGenerarDocumento",'<iframe src="<%= request.getContextPath() %>/generarDocumentoSinCaso.do?formaId=13&esconderArbol=1&idAudiencia='+idAudiencia+'" width="1140" height="400" />');
				  		}
				  	}
			  	}
		  	}
	}

	/*
	*Funcion para registrar una solicitud de AV/ o transcripcion de audiencia
	*/
	function registraSolicitud(tipo){

		var params = 'tipoSolicitud=' + tipo+'idEvento='+ idAudiencia;

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/registrarSolicitudPJENS.do',
			data: params,
			dataType: 'xml',
			async: false,
			success: function(xml){
					numeroDeSalas = $(xml).find('valorDTO').find('valor').text();

			}
		});
	}

	/*se le avisa cuando ya esta finalizada la audiencia/*Enable IT ByYolo*/
	function validaAudiencia(){
		consultaEstatusAudiencia(idEvento);
		if(estatusAudiencia!=<%=EstatusAudiencia.FINALIZADA.getValorId()%> && 
				estatusAudiencia!=<%=EstatusAudiencia.CANCELADA.getValorId()%>){
			finalizarAudiencia();
		}else{
			alertDinamico('La Audiencia esta en estatus finalizada.');
		}
	}
	
	function consultaEstatusAudiencia(idEvento){

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/detalleAudienciasDelDiaPJENS.do',
			data: 'idEvento='+ idEvento,
			async: false,
			dataType: 'xml',
			success: function(xml){
    					estatusAudiencia=$(xml).find('estatusAudiencia').find('idCampo').first().text();
					
    			}
		});
	}

	
	/**
	*Funcion para guardar la programacion de la audiencia y finalizar la audiencia
	*/
	function finalizarAudiencia(){

		var parametros = 'idAudiencia='+idAudiencia;

        $.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/finalizarAudienciaPJENS.do',
			data: parametros,
			dataType: 'xml',
			async: false,
			success: function(xml){

				if($(xml).find('mensaje').text() == "exito"){
					alertDinamico("Finalizaci�n de la audiencia realizada correctamente");
				}else{
					alertDinamico("No se puede finalizar la audiencia si no se ha generado el acta de la audiencia primero");
				}
			}
		});
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




	/*
	*Funcion que consulta el detalle del evento y llena
	*los campos de la TAB Programar Audiencia
	*/
	/////////////////////NO SE ESTA USANDO
	function consultaDetalleEventoProgramarAudiencia(){

		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/detalleAudienciasDelDiaPJENS.do',
			data: 'idEvento='+ idAudienciaSiguiente,
			async: false,
			dataType: 'xml',
			success: function(xml){
				var errorCode;
				errorCode=$(xml).find('response').find('code').text();
				if(parseInt(errorCode)==0){


    				limpiaDatosDetalleEvento();


    				//Tab Programar Audiencia
    				tipoAudiencia = $(xml).find('tipoAudiencia').find('idCampo').first().text();
    				$("#numCasoProgramarAudiencia").val($(xml).find('numeroGeneralCaso').first().text());
    				$("#numExpedienteProgramarAudiencia").val($(xml).find('numeroExpediente').first().text());
    				$("#fechaLimiteProgramarAudiencia").val($(xml).find('strFechaLimite').first().text());
						//LLama a cargar combo de tipos de audiencia para la ceja programar audiencia
    					cargaComboTipoAudiencia(tipoAudiencia);
    			}
				else{
					//Mostrar mensaje de error
				}
			}
		});
	}


		function gridTraspasos(){
			/**
			*Funcion que llena el grid de traslado
			*/
			jQuery("#gridTrasladoPJA").jqGrid({
				datatype: "xml",
				colNames:['Imputado','Delito','Centro de Detenci�n'],
				colModel:[ 	{name:'imputado',index:'imputado', width:200,align:'center'},
							{name:'Delito',index:'delito', width:100,align:'center'},
							{name:'centroDetencion',index:'centroDetencion', width:200,align:'center'}

						],
				pager: jQuery('#pager2'),
				rowNum:10,
				rowList:[10,20,30],
				autowidth: true,
				sortname: 'detalle',
				viewrecords: true,
				sortorder: "desc"
			}).navGrid('#pager2',{edit:false,add:false,del:false});
			}


		//function abreSelect(){
		//$("#finalAudienciaOpcion").multiselect('open');
		//$("#finalAudienciaOpcion").multiselect('refresh');
		//}

//**********************************************************************FUNCIONALIDAD DESCONOCIDA****************************************************************
	function detalleInvolucradosPJENS(idRow){


		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarDetalleInvolucradoPJENS.do?idInvolucrado='+idRow+'',
			async: false,
			dataType: 'xml',
			success: function(xml){

				 var IDPAIS_MEXICO = 10;

				$("#nombre").val($(xml).find('nombre').text());
				$("#apellidoPaterno").val($(xml).find('apellidoPaterno').text());
				$("#apellidoMaterno").val($(xml).find('apellidoMaterno').text());
				$("#cmbInstitucion").val($(xml).find('id').text());
				$("#correo").val($(xml).find('direccionElectronica').text());
				$("#codigoPostal").val($(xml).find('domicilio').find('asentamientoDTO').find('codigoPostal').text());
				$('#cbxPais option:selected').val($(xml).find('domicilio').find('asentamientoDTO').find('municipioDTO').find('entidadFederativaDTO').find('valorIdPais').find('idCampo').text());

				var idPais = $('#cbxPais option:selected').val();

				 if(idPais==IDPAIS_MEXICO){

			           var entidadFede=$(xml).find('domicilio').find('asentamientoDTO').find('municipioDTO').find('entidadFederativaDTO').find('entidadFederativaId').text();
			           $('#cbxEntFederativa').find("option[value='"+entidadFede+"']").attr("selected","selected");
			           $('#cbxEntFederativa').multiselect('refresh');
			           //onSelectChangeEntFed();
				       $('#cbxCiudad option:selected').val($(xml).find('Pais').text());
				       var municipio=$(xml).find('domicilio').find('asentamientoDTO').find('municipioDTO').find('municipioId').text();
					   $('#cbxDelegacionMunicipio').find("option[value='"+municipio+"']").attr("selected","selected");
			           $('#cbxDelegacionMunicipio').multiselect('refresh');
				       $('#cbxAsentamientoColonia option:selected').val($(xml).find('Pais').text());
			           $('#cbxTipoAsentamiento option:selected').val($(xml).find('Pais').text());
			           $('#cbxTipoCalle option:selected').val($(xml).find('Pais').text());

			        }else{
			            $('#entidadFederativa').val($(xml).find('Pais').text());
			            $('#areaCiudad').val($(xml).find('Pais').text());
			            $('#areaDelegacionMunicipio').val($(xml).find('Pais').text());
			            $('#areaColonia').val($(xml).find('Pais').text());
			            $('#areaAsentamiento').val($(xml).find('Pais').text());
			            $('#areaTipoCalle').val($(xml).find('Pais').text());
			        }

				$("#areaCalle").val($(xml).find('domicilio').find('calle').text());
				$("#areaNumeroExterior").val($(xml).find('domicilio').find('numeroExterior').text());
				$("#areaNumeroInterior").val($(xml).find('domicilio').find('numeroInterior').text());
				$("#areaReferencias").val($(xml).find('domicilio').find('referencias').text());
				$("#areaEntreCalle").val($(xml).find('domicilio').find('entreCalle1').text());
				$("#areaYCalle").val($(xml).find('domicilio').find('entreCalle2').text());
				$("#areaAlias").val($(xml).find('domicilio').find('alias').text());
				$("#areaEdificio").val($(xml).find('tipoAudiencia').find('valor').text());
				$("#txtFldLongitud").val($(xml).find('').text());
				$("#txtFldLatitud2").val($(xml).find('').text());
				domicilioId = $(xml).find('domicilio').find('elementoId').text();

			}
		});

		$("#agregarDestinatario").dialog("open");
	  	$("#agregarDestinatario").dialog({ autoOpen: true,
			modal: true,
		  	title: 'Detalle del Involucrado',
		  	dialogClass: 'alert',
		  	position: [312,40],
		  	width: 880,
		  	height: 510,
		  	maxWidth: 1000,
		  	buttons:{"Guardar":function() {

	            var IDPAIS_MEXICO = 10;
		        var idPais = $('#cbxPais option:selected').val();
		        var parametros = 'pais=' + idPais;
		        parametros += '&codigoPostal=' +  $('#codigoPostal').val();
		        //Cambiar por el id de Mexico
		        if(idPais==IDPAIS_MEXICO){
		            parametros += '&entidadFederativa=' + $('#cbxEntFederativa option:selected').val();
		            parametros += '&ciudad=' + $('#cbxCiudad option:selected').val();
		            parametros += '&delegacionMunicipio=' + $('#cbxDelegacionMunicipio option:selected').val();
		            parametros += '&asentamientoColonia=' + $('#cbxAsentamientoColonia option:selected').val();
		            parametros += '&tipoAsentamiento=' + $('#cbxTipoAsentamiento option:selected').val();
		            parametros += '&tipoCalle=' + $('#cbxTipoCalle option:selected').val();
		        }else{
		            parametros += '&entidadFederativa=' + $('#entidadFederativa').val();
		            parametros += '&ciudad=' + $('#areaCiudad').val();
		            parametros += '&delegacionMunicipio=' + $('#areaDelegacionMunicipio').val();
		            parametros += '&asentamientoColonia=' + $('#areaColonia').val();
		            parametros += '&tipoAsentamiento=' + $('#areaAsentamiento').val();
		            parametros += '&tipoCalle=' + $('#areaTipoCalle').val();
		        }

		        parametros += '&calle=' + $('#areaCalle').val();
		        parametros += '&numExterior=' + $('#areaNumeroExterior').val();
		        parametros += '&numInterior=' + $('#areaNumeroInterior').val();
		        parametros += '&referencias=' + $('#areaReferencias').val();
		        parametros += '&entreCalle=' + $('#areaEntreCalle').val();
		        parametros += '&ycalle=' + $('#areaYCalle').val();
		        parametros += '&aliasDomicilio=' + $('#areaAlias').val(); //ALIAS DE DOMICILIO?
		        parametros += '&edificio=' + $('#areaEdificio').val();
		        parametros += '&longitud=' + $('#txtFldLongitud').val();
		        parametros += '&latitud=' + $('#txtFldLatitud2').val();

		        parametros += '&nombre=' + $("#nombre").val();
		        parametros += '&aPaterno=' + $("#apellidoPaterno").val();
		        parametros += '&aMaterno=' + $("#apellidoMaterno").val();

		        if($("#cmbInstitucion option:selected").val() == "Ministerio P�blico"){
		        	parametros +='&institucion=' + 1;
				}else{
					parametros +='&institucion=' + 2;
				}
		        parametros += '&correo=' + $("#correo").val();

		       parametros += '&domicilioId=' + domicilioId;

		        $.ajax({
					type: 'POST',
					url: '<%= request.getContextPath()%>/modificarDatosInvolucrado.do?idInvolucrado='+idRow+'',
					data: parametros,
					dataType: 'xml',
					async: false,
					success: function(xml){
						$(xml).find('catPaises').each(function(){
							$('#cbxPais').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
							$('#cbxPais').multiselect('refresh');
							});
					}
				});

		  			$(this).dialog("close");
		  		},
		  		"Cancelar":function() {
		  			$(this).dialog("close");
		  		}
		  	}
		});
	}


	function  ocultaBotones(){
		if($("#gridFiscal_Nombre").display=="none"){
		$("#botonesFiscal").css("display","none");
		}else $("#botonesFiscal").css("display","block");
	}


	function tipoEslabon(){


		$("#divActuacionesCambioaBoton").dialog("open");
		$("#divActuacionesCambioaBoton").dialog({ autoOpen: true,
			modal: true,
		  	title: 'Resolutivo',
		  	dialogClass: 'alert',
		  	position: [30,30],
		  	width: 437,
		  	height: 441,
		  	maxWidth: 800
		});
	}



	//variable para controlar cuando se recarga el grid
	var cargaGridImputadosProgAudiencia = true;

	/**
	*Funcion que recarga el grid con los imputados de la audiencia
	*/
	function cargaImputadosProgramarAudiencia(idEvento){

		if(cargaGridImputadosProgAudiencia == true){

			jQuery("#gridsImputadosAudiencia").jqGrid({

				url:'<%= request.getContextPath()%>/consultarImputadoMaximaAudiencia.do?idEvento='+idEvento+'',
				datatype: "xml",
				colNames:['Nombre'],
				colModel:[
						{name:'nombre',index:'nombre', width:150}
				],
				pager: jQuery('#pagerinv'),
				rowNum:10,
				rowList:[10,20,30],
				autowidth: true,
				sortname: 'detalle',
				viewrecords: true,
				sortorder: "desc",
				multiselect: true,
				caption:"Imputados"
			}).navGrid('#pagerinv',{edit:false,add:false,del:false});

			cargaGridImputadosProgAudiencia= false;
		}
		else{
			jQuery("#gridsImputadosAudiencia").jqGrid('setGridParam', {url:'<%= request.getContextPath()%>/consultarImputadoMaximaAudiencia.do?idEvento='+idEvento+'' ,datatype: "xml" });
			$("#gridsImputadosAudiencia").trigger("reloadGrid");
		}


	}


	function guardarRR(){alertDinamico('Recurso y resoluci�n registrados correctamente');}

	//********************************************************************************************************************************************************************/

	function eliminarAudienciaJAVS(){
		$.ajax({
			type: 'POST',
			url:'<%= request.getContextPath()%>/eliminarAudienciaJavs.do?idAudiencia='+idAudiencia+'',
			data:'',
			dataType: 'xml',
			async: false,
			success: function(xml){
				var respuesta;
				respuesta=$(xml).find('response').find('body').find('long').text();
				var s_MENSAJE=mensajeEstadoJAVSEliminacion(respuesta);
				if(s_MENSAJE!=""){
					alertDinamico(s_MENSAJE);
				}
				else{
					// Puede ser error de conexi�n WS
					alertDinamico("Fallo al eliminar la audiencia");
				}
				$("#gridAudienciasResolutivosPJENS").trigger("reloadGrid");
			}
		});
	}

	function mensajeEstadoJAVSEliminacion(idEvento){
		var s_MENSAJE="";
		switch (idEvento){
        case "<%=ConstantesGenerales.FALLO_GENERAL%>":
            s_MENSAJE = "Fallo al conectar con el servidor JAVS.</br>Vuelva a intentarlo m�s tarde";
            break;
        case "<%=ConstantesGenerales.FALLO_GENERAL_JAVS%>":
            s_MENSAJE = "Fallo al conectar con el servidor JAVS.</br>Vuelva a intentarlo m�s tarde";
            break;
        case "<%=ConstantesGenerales.ERROR_CREDENCIALES_CONSULTA%>":
        	s_MENSAJE = "Fallo al conectar con el servidor JAVS, Error en credenciales.</br>vuelva a intentarlo m�s tarde";
            break;
        case "<%=ConstantesGenerales.AUDIENCIA_PROCESO%>":
        	s_MENSAJE = "La audiencia no fue cancelada, ya que esta programada en Sala JAVS y ya se esta llevando a cabo.</br>Se han actualizado los datos de la audiencia";
            break;
        case "<%=ConstantesGenerales.AUDIENCIA_TERMINO%>":
        	s_MENSAJE = "La audiencia no fue cancelada, ya que esta programada en Sala JAVS y ya se llevo a cabo.</br>Se han actualizado los datos de la audiencia";
            break;
        case "<%=ConstantesGenerales.ERROR_ELIMINACION%>":
            s_MENSAJE = "La audiencia no fue eliminada, ocurri� un problema.</br>Vuelva a intentarlo m�s tarde";
            break;
        case "<%=ConstantesGenerales.EXITO_ELIMINACION%>":
            s_MENSAJE = "Se elimin� correctamente la agenda del registro del AutoLog del servidor JAVS";
            break;
        case "<%=ConstantesGenerales.NO_HAY_AUDIENCIAS%>":
            s_MENSAJE = "No se encontr� la audiencia registrada en el AutoLog de JAVS";
            break;
        case "<%=ConstantesGenerales.ERROR_SERVICIO_ELIMINACION%>":
            s_MENSAJE = "Fallo al conectar con el servidor JAVS.</br>Vuelva a intentarlo m�s tarde";
            break;
        case "<%=ConstantesGenerales.NO_ES_JAVS%>":
            s_MENSAJE = "La audiencia no se llevo a cabo en una Sala JAVS";
            break;
        }
        return s_MENSAJE;
	}


   function cierraVentanaRegistrarAmparo(){
		var pantalla ="iframewindowRegistrarAmparo";
		//pantalla += idWindowIngresarProbResponsable;
		$.closeWindow(pantalla);
	}

	function consultaPDF(id){
		document.frmDococumentos.documentoId.value = id;
		document.frmDococumentos.submit();
	}

	function ismaxlength(obj,size){
		if (obj.value.length>size)
			obj.value=obj.value.substring(0,size);
	}

	/*
	*Funcion que valida, que la hora y minuto seleccionados sean mayores o iguales
	*a la hora del servidor, para programar la audiencia, regresa true, en caso
	*verdadero, false caso contrario.
	*/
    function validaHoraAudienciaHoraActual(horaSelec, minutoSelec){

		var fecha = "";

		$.ajax({
			type: 'POST',
			url: '<%=request.getContextPath()%>/regresaFechaYHoraDelServidor.do',
			dataType : 'xml',
			async : false,
			success : function(xml) {
				fecha = $(xml).find('fecha').text();
			}
		});

		//mes y anio seleccionados
		var mesSelec = $('#mes').val();
		var anioSelec = $('#anio').val();

		//hora, minuto, dia, mes y anio actuales
		var horaC = fecha.substring(11, 13);
		var minutoC = fecha.substring(14,16);

		var dia = fecha.substring(8, 10);
		var mes = meses[parseInt(fecha.substring(5, 7)) - 1];
		var anio = fecha.substring(0, 4);

		if (parseInt(fechaReal) == parseInt(dia) && mesSelec == mes
				&& parseInt(anioSelec) == parseInt(anio)) {
			if (parseInt(horaSelec) > parseInt(horaC)) {
				return true;
			}
			else{
				if(parseInt(horaSelec) == parseInt(horaC)){
					if(parseInt(minutoSelec)  >= parseInt(minutoC)){
						return true;
					}
					else{
						return false;
					}
				}
				else{
					return false;
				}
			}
		}
		else {
			return true;
		}
	}

    function documentos(){
		 jQuery("#gridDetalleFrmPrincipal").jqGrid('setGridParam',
					{url:'<%= request.getContextPath()%>/consultarDocumentosPorAudiencia.do?idAudiencia='+idAudiencia,
					datatype: "xml" ,
					loadComplete: function(){
						rows = jQuery("#gridDetalleFrmPrincipal").jqGrid('getGridParam','records')
						if (rows<=0)
							customAlert("No hay documentos asociados para la audiencia");
					},
					success: function(xml){
						alertDinamico('<%= request.getSession().getAttribute("totalRegistrosDocumentos")%>');
					 }
					});
				 $("#gridDetalleFrmPrincipal").trigger("reloadGrid");
	}

    /*Actuaciones parametricas*/
     function cargaActuaciones() {
		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/cargarActuaciones.do?numeroExpediente='+numeroExpediente,
			data: '',
			dataType: 'xml',
			async: false,
			success: function(xml){
				$(xml).find('catActuaciones').each(function(){
					$('#cbxAccionesTab').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

    /* ENABLE IT: Se agregan actuaciones param�tricas */
    function seleccionaActuacion(){
		var selected = $("#cbxAccionesTab option:selected");
		var confActividadId=selected.val();
		var actividad=0;
		var formaID=4;
		var titulo="op";
		var usaeditor="";
		var estatusId="";
		var nombreActividad="";


		$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/obtenerConfActividadDocumento.do?idConf='+confActividadId,
			data: '',
			dataType: 'xml',
			async: false,
			success: function(xml){
				actividad=$(xml).find('confActividadDocumentoDTO').find('tipoActividadId').text();
				formaID=$(xml).find('confActividadDocumentoDTO').find('formaId').text();
				titulo=$(xml).find('confActividadDocumentoDTO').find('nombreDocumento').text();
				usaeditor=$(xml).find('confActividadDocumentoDTO').find('usaEditor').text();
				estatusId=$(xml).find('confActividadDocumentoDTO').find('estadoCambioExpediente').find('idCampo').text();
				nombreActividad=$(xml).find('confActividadDocumentoDTO').find('nombreActividad').text();
			}
		});

		ejecutaActuacion(selected, confActividadId, actividad, formaID, titulo, usaeditor, estatusId);
	}

    function ejecutaActuacion(selected, confActividadId, actividad, formaID, titulo, usaeditor, estatusId){
    	if(usaeditor== "true"){
    		registrarActividadExpediente(actividad,estatusId,0);
	     	$.newWindow({id:"iframewindowGenerarDocumento", statusBar: true, posx:200,posy:50,width:1140,height:400,title:""+titulo, type:"iframe"});
	    	$.updateWindowContent("iframewindowGenerarDocumento",'<iframe src="<%= request.getContextPath() %>/generarDocumentoSinCaso.do?formaId='+formaID+'&numeroUnicoExpediente='+numeroExpediente+'&idAudiencia='+idAudiencia+'" width="1140" height="400" />');
	    	$("#" +"iframewindowGenerarDocumento" + " .window-maximizeButton").click();
		}
	}

    function registrarActividadExpediente(actuacionID,estatusId,banderaMensaje){
    	//Cambia la actividad del expediente
    	$.ajax({
			type: 'POST',
			url: '<%= request.getContextPath()%>/registraActividadExpediente.do?idExpediente='+idExpediente+'&actuacion='+actuacionID+'&estatus='+estatusId,
			data: '',
			dataType: 'xml',
			async: false,
			success: function(xml){
				if(parseInt(banderaMensaje)==1)
				{
					customAlert("Actividad nueva registrada");
				}
			}
		});
	}


	</script>
</head>
<body>

<div id="tabsDetalleAudiencias">

	<ul>
		<li id="detalleAudiencias">
			<a href="#tabsDetalleAudiencias-1">Detalle de Audiencias</a>
		</li>
		<li id="involucrados">
			<a href="#tabsDetalleAudiencias-2">Individualizaci�n</a>
		</li>
		<li id="Objetos">
			<a href="#tabsDetalleAudiencias-3">Pruebas</a>
		</li>
		<li id="resolutivos">
			<a href="#tabsDetalleAudiencias-4">Resolutivos de Audiencia</a>
		</li>
		<li id=calendario>
			<a href="#tabsDetalleAudiencias-5">Programar Audiencia</a>
		</li>
		<li id="acciones" style="display: none;">
			<a href="#tabsDetalleAudiencias-6">Acciones</a>
		</li>
		<li id="finalAudienciaPes">
			<a href="#tabsDetalleAudiencias-7">Administrar actuaciones de audiencia</a>
		</li>
		<!--Enable IT : Ocultando etiqueta Administrar Recurso
		<li id="administrarRecurso">
			<a href="#tabsDetalleAudiencias-8">Administrar Recurso</a>
		</li> -->
        <li class="tabTabsAmparos">
        	<a href="#tabs-10" onclick="consultarAmparosPorExpediente()">Amparo</a>
        </li>
		<li class="tabTabsDocs">
			<a href="#tabs-11" onclick="documentos()">Documentos</a>
		</li>
		<li id="notificaciones">
			<a href="#tabNotificaciones-12">Notificaciones</a>
		</li>
	</ul>


	<!--Comienza Tab Detalle de audiencia-->
	<div id="tabsDetalleAudiencias-1" >

		<table width="1060" height="100%" border="0" align="center" cellpadding="0" cellspacing="5" class="back_generales">
		<tbody>
			<tr valign="top">
			</tr>
			<tr height="20%" valign="middle">
				<td colspan="4" valign="middle" align="center"><strong>Audiencia:
				  <input type="text"
					id="audienciaPJENS"
					style="width: 200px; border: 0; background: #DDD;"
					readonly="readonly" />
				</strong></td>

			</tr>
	        <tr>
	        	<td colspan="4" align="center"><strong>Tipo de Audiencia:
	        	  <input type="text"
					id="tipoAudienciaPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly" />
	        	</strong></td>
	        </tr>
			<tr>
				<td width="13%" align="right">&nbsp;</td>
				<td width="8%">&nbsp;</td>
				<td width="18%">&nbsp;</td>
				<td width="25%">&nbsp;</td>
			</tr>
			<tr>
			  <td width="22%" align="right"><strong>N�mero de Caso:</strong></td>
			  <td width="17%"><input type="text"
					id="numCasoPJENS"
					style="width: 180px; border: 0; background: #DDD;"
					readonly="readonly" /></td>
				<td colspan="2" rowspan="8">
				<table id="gridAudienciasPJENC"></table>
				<div id="pager1" width="300"></div>
				</td>
			</tr>
			<tr>
			  <td align="right"><strong>N�mero de Causa:</strong></td>
			  <td><input type="text" id="numExpPJENS"
					style="width: 180px; border: 0; background: #DDD;"
					readonly="readonly"  /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Car�cter: </strong></td>
			  <td><input type="text" id="caracterPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly" /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Fecha:</strong></td>
			  <td><input type="text" id="fechaAudienciaPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly"  /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Hora:</strong></td>
			  <td><input type="text" id="horaAudienciaPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly" /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Sala:</strong></td>
			  <td><input type="text" id="salaPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly"  /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Direcci�n de Sala:</strong></td>
			  <td><input type="text" id="direccionSalaPJENS"
					style="width: 150px; border: 0; background: #DDD; "
					readonly="readonly"
					 /></td>
			</tr>
			<tr>
			  <td align="right"><strong>Ubicaci�n:</strong></td>
			  <td><input type="text" id="ubicacionPJENS"
					style="width: 150px; border: 0; background: #DDD;"
					readonly="readonly" /></td>
			</tr>
	        <tr>
	        	<td>&nbsp;</td>
	            <td>&nbsp;</td>
	            <td align="right"><strong>Juez(ces):</strong></td>
	            <td>
					<!--<input type="text" id="juezPJENS" style="width: 180px; border: 0; background: #DDD;" readonly="readonly"/>-->
					<select id="juezPJENS" style="width: 200px; border: 0; background:#DDD;"></select>
				</td>
	        </tr>
<!-- 	        /*inicio de espacio/*Enable IT ByYolo*/ -->
	        <tr>
	          <td width="22%" align="right"><strong></strong></td>
			  <td width="20%"></td>
	        	<td colspan="2" rowspan="2">
				<table id="gridSolicituesDefensorPJENC"></table>
				<div id="pager11" width="100"></div>
				</td>
	        </tr>
<!-- 	        /*fin de espacio/*Enable IT ByYolo*/ -->
	        <tr>
	        	<td>&nbsp;</td>
	            <td>&nbsp;</td>
	            <td align="right">&nbsp;</td>
	            <td>&nbsp;</td>
	        </tr>
	        <tr>
	        	<td>&nbsp;</td>
	            <td>&nbsp;</td>
	            <td align="left">
	            	<table cellspacing="0" cellpadding="0">
						<tr>
							<td width="158" align="right">&nbsp;</td>
						</tr>
	            	</table>
	            </td>
	            <td>
	            	<table cellspacing="0" cellpadding="0">
						<tr>
						  <td width="151">&nbsp;</td>
						</tr>
					</table>
				</td>
	        </tr>
	        <tr height="300">
	        	<td>&nbsp;</td>
	            <td>&nbsp;</td>
	            <td align="left">
					<table cellspacing="0" cellpadding="0">
					  <tr>
					    <td width="158" align="right">&nbsp;</td>
					  </tr>
					</table>
				</td>
	            <td>
	            	<table cellspacing="0" cellpadding="0">
						<tr>
						  <td width="151">&nbsp;</td>
						</tr>
	            	</table>
	            </td>
	        </tr>
	    </tbody>
		</table>
	</div>
	<!--Termina Tab Detalle de audiencia-->


	<!--Comienza Tab Individualizacion-->
	<div id="tabsDetalleAudiencias-2">
		<div id="tabschild2" class="tabs-bottom">

			<ul>
				<li><a href="#tabschild2-6">V&iacute;ctima</a></li>
				<li><a href="#tabschild2-7">Denunciante</a></li>
				<li><a href="#tabschild2-1">Fiscal</a></li>
				<li><a href="#tabschild2-2">Defensor</a></li>
				<li><a href="#tabschild2-3">Testigo</a></li>
				<li><a href="#tabschild2-4">Perito</a></li>
				<li><a href="#tabschild2-5">Polic�a Ministerial</a></li>
			</ul>

			<!--Comienzan  Sub Tabs para la ceja de individualizacion -->
			<div id="tabschild2-6">
				<div id="divGridVictima" >
					<table id="gridVictima" ></table>
					<div id="paginadorGridVictima"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>

				<div id="divGridVictimaOrg" >
					<table id="gridVictimaOrg" ></table>
					<div id="paginadorGridVictimaOrg"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-7">
				<div id="divGridDenunciante" >
					<table id="gridDenunciante" ></table>
					<div id="paginadorGridDenunciante"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-1">
				<div id="divGridFiscal" >
					<table id="gridFiscal" ></table>
					<div id="paginadorGridFiscal"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-2">
				<div id="divGridDefensor">
					<table id="gridDefensor"></table>
					<div id="paginadorGridDefensor"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-3">
				<div id="divGridTestigo">
					<table id="gridTestigo"></table>
					<div id="paginadorGridTestigo"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-4">
				<div id="divGridPerito">
					<table id="gridPerito"></table>
					<div id="paginadorGridPerito"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

			<div id="tabschild2-5">
				<div id="divGridPolicia">
					<table id="gridPolicia"></table>
					<div id="paginadorGridPolicia"></div>
				</div>

				<table>
					<tr><td></br></td></tr>
					<tr><td></br></td></tr>
				</table>
			</div>

		</div>
		<!--Espacio para los grids de individualizacion	-->
	</div>
	<!--Termina Tab Individualizacion-->

	<!--Comienza Tab de Objetos-->
	<div id="tabsDetalleAudiencias-3">




			<!--Comienzan sub cejas de pruebas-->
			<div id="tabschildPruebasPJENS" class="tabs-bottom">

				<ul>
					<li><a href="#tabschildPruebasPJENS-1">Datos de Prueba</a></li>
					<li><a href="#tabschildPruebasPJENS-2">Medios de Prueba</a></li>
					<li><a href="#tabschildPruebasPJENS-3">Prueba</a></li>
				</ul>


							<!--Comienza Sub Tab Datos de prueba  -->
							<div id="tabschildPruebasPJENS-1">

								<table width="1000" border="0" cellspacing="0" cellpadding="0">
								  <tr>
								    <td width="100">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="100">&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td colspan="2" rowspan="11">
										<table  id="gridDatosDePruebaPJENS" width="100%"></table>
										<div id="pagerGridDatosDePruebaPJENS"></div>
									</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								</table>

							</div>
							<!--Termina Sub Tab Datos de prueba  -->


							<!--Comienza Sub Tab Medios de prueba  -->
							<div id="tabschildPruebasPJENS-2">

								<table width="1000" border="0" cellspacing="0" cellpadding="0">
								  <tr>
								    <td width="100">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="100">&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td colspan="2" rowspan="11">
										<table  id="gridMediosDePruebaPJENS" width="100%"></table>
										<div id="pagerGridMediosDePruebaPJENS"></div>
									</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								</table>

							</div>
							<!--Termina Sub Tab Medios de prueba  -->

							<!--Comienza Sub Tab prueba  -->

							<div id="tabschildPruebasPJENS-3">

								<table width="1000" border="0" cellspacing="0" cellpadding="0">
								  <tr>
								    <td width="100">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="400">&nbsp;</td>
								    <td width="100">&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td colspan="2" rowspan="11">
										<table  id="gridPruebaPJENS" width="100%"></table>
										<div id="pagerGridPruebaPJENS"></div>
									</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								  <tr>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								    <td>&nbsp;</td>
								  </tr>
								</table>

							</div>
							<!--Termina Sub Tab prueba  -->

			</div>
			<!--Terminan sub cejas de pruebas-->


	</div>
	<!--Termina Tab de Objetos-->

	<!--Comienza Tab Resolutivos de Audiencia-->
	<div id="tabsDetalleAudiencias-4">
		<table width="1060" align="center" height="100%" class="back_obj" border="0" cellpadding="0" cellspacing="5">
			<tbody>
			<tr>
				<td rowspan="8" width="5%">&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
			  <td width="10%" align="right" valign="top">
			  	<strong>Audiencia: </strong>
			  </td>
			  <td width="5%" valign="top" align="left">
			  	<input type="text" id="audienciaResPJENS" style="width:150px; border: 0; background:#DDD;" readonly="readonly" />
			  </td>
			  <td width="15%" align="right" valign="top">
			  	<strong>Tipo  Audiencia:</strong>
			  </td>
			  <td width="10%" valign="top" align="left">
			  	<input type="text" id=tipoAudienciaResPJENS style="width:150px; border: 0; background:#DDD;" readonly="readonly" value="Juicio Oral"/>
			  </td>
			  <td width="15%" align="left" valign="top">&nbsp;</td>

	  		</tr>
			<tr>
				<td width="10%" align="right" valign="top">
					<strong>No.  Caso:</strong>
				</td>
				<td valign="top">
					<input type="text" id="numCasoResPJENS" style="width:200px; border: 0; background:#DDD;" readonly="readonly" />
				</td>
				<td align="right" valign="top">
					<strong>No. Causa:</strong>
				</td>
				<td valign="top">
					<input type="text" id="numExpResPJENS" style="width:200px; border: 0; background:#DDD;" readonly="readonly" value="000001"/>
				</td>
				<td width="15%" align="left" valign="top">&nbsp;</td>
			</tr>
	  		<tr>
	  			<td align="left">
    				<input class="btn_mediano" width="100" type="button" id="agregarResolutivoBoton" value="Agregar Registro" />
    			</td>
				<td valign="top" height="200" rowspan="6" colspan="3" align="center" >
					<table  id="gridAudienciasResolutivosPJENS" width="100%"></table>
					<div id="pager5"></div>
				</td>
			</tr>
			<tr>
    			<td align="right">
    				<input type="button" class="btn_mediano" width="100" id="eliminarResolutivoBoton" value="Eliminar Registro" />
    			</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" class="btn_mediano" width="100" id="btnVideos" value="Notas y Videos de JAVS" onclick="invocacionSolicitudJAVS()"/>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" class="btn_mediano" width="100" id="btnEliminar" value="Eliminar agenda de JAVS" onclick="eliminarAudienciaJAVS();"/>
				</td>
			</tr>
			</tbody>
	  	</table>

		<table width="1060" align="center" height="354" class="back_hechos" border="0" cellpadding="0" cellspacing="0">
	  		<tr valign="top">
  			  <td height="5" colspan="2">&nbsp;</td>
			</tr>
            <tr>
				<td width="18%" align="right">
					<ul class="botonLeyes"></ul>
				</td>
	  		</tr>
			<tr valign="middle">
				<td width="5%" height="40" align="right">
					<input class="btn_mediano" type="button" id="consPolitica" onClick="abreCodigosLeyes('<%=TipoNorma.CONSTITUCION.getValorId()%>')" value="Constituci&oacute;n Pol&iacute;tica"/>
				</td>
			  	<td width="8%" rowspan="9" valign="middle" >
					<table id="gridLeyesCodigosPJENS" width="100%">
					</table>
		     		 <div id="pager10"></div>
				</td>
  			</tr>
			<tr>
				<td width="5%" height="39" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="leyesGenerales" onClick="abreCodigosLeyes('<%=TipoNorma.LEYES.getValorId()%>')" value="Leyes Generales"/>
				</td>
			</tr>
			<tr>
				<td width="5%" height="40" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="tratados" onClick="abreCodigosLeyes('<%=TipoNorma.TRATADOS.getValorId()%>')" value="Tratados Internacionales"/>
				</td>
			</tr>
			<tr>
				<td  width="5%" height="40" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="codigos" onClick="abreCodigosLeyes('<%=TipoNorma.CODIGOS.getValorId()%>')" value="C&oacute;digos" />
				</td>
	  		</tr>
			<tr>
				<td width="5%" height="40" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="acuerdos" onClick="abreCodigosLeyes('<%=TipoNorma.ACUERDOS.getValorId()%>')" value="Acuerdos" />
				</td>
	  		</tr>
			<tr>
				<td width="18%" height="40" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="circulares" onClick="abreCodigosLeyes('<%=TipoNorma.CIRCULARES.getValorId()%>')" value="Circulares" />
				</td>
	  		</tr>
			<tr>
				<td  width="18%" height="39" align="right" class="linea_derecha_gris">
					<input class="btn_mediano" type="button" id="manuales" onClick="abreCodigosLeyes('<%=TipoNorma.MANUALES.getValorId()%>')" value="Manuales" />
				</td>
	  		</tr>
			<tr>
				<td width="18%" align="right">
			  		<input class="btn_mediano" type="button" id="instructivos" onClick="abreCodigosLeyes('<%=TipoNorma.INSTRUCTIVOS.getValorId()%>')" value="Instructivos" />
				</td>
	  		</tr>
            <tr>
				<td width="18%" align="right">
				</td>
	  		</tr>
		</table>
	</div>
	<!--Termina Tab Resolutivos de Audiencia-->


	<!--Comienza Tab Programar Audiencia-->
	<div id="tabsDetalleAudiencias-5">

		<!--Comienzan sub cejas de programar audiencia-->
		<div id="tabschild" class="tabs-bottom">

			<ul>
				<li><a href="#tabschild-1">Audiencia</a></li>
				<li><a href="#tabschild-2">Imputado</a></li>
				<li><a href="#tabschild-8">V&iacute;ctima</a></li>
				<li><a href="#tabschild-9">Denunciante</a></li>
				<li><a href="#tabschild-3">Testigo</a></li>
				<li><a href="#tabschild-4">Perito</a></li>
				<li><a href="#tabschild-5">Polic�a Ministerial</a></li>
				<li><a href="#tabschild-6">Fiscal</a></li>
				<li><a href="#tabschild-7">Defensor</a></li>
				<!--<li><a href="#tabschild-3">Objetos</a></li>-->
			</ul>

			<!--Comienza Sub Tab para audiencia  -->
			<div id="tabschild-1">

				<!--<table width="1100" class="back_generales" border="0" cellspacing="0" cellpadding="0">-->
				<table width="1100" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="258">&nbsp;</td>
						<td width="178">&nbsp;</td>
						<td colspan="3" align="center" valign="bottom">
							<input type="button" class="btn_Generico" value="<<" id="btnAtrasMes" onClick="atrasAdelanteMes('atras');"/>
							<input type="text" id="mes" disabled="disabled" style="width: 70px"/>
							<input type="text" id="anio" disabled="disabled" style="width: 70px" />
							<input type="button" class="btn_Generico" value=">>" id="btnAdelanteMes" onClick="atrasAdelanteMes('adelante');"/>
						</td>
						<td width="100" nowrap="nowrap">
							<strong>Asignar Juez:</strong>
						</td>
					 	<td colspan="2">
							<table width="100%" cellpadding="1" cellspacing="1">
								<tr>
									<td colspan="2">
										<input type="checkbox" value="true" name="juezSustituto" id="juezSustituto"/> Juez sustituto
									</td>
								</tr>
								<tr>
									<td width="111">
										<input type="button" class="btn_Generico" value="Manualmente" id="btnAsignarJuezManual" onclick="controlJueces(false);"/>
									</td>
									<td width="125">
										<input type="button" class="btn_Generico" value="Autom&aacute;ticamente" id="btnAsignarJuezAuto" onclick="controlJueces(true);"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
		  			<tr>
		    			<td align="right" valign="bottom">
		    				<strong>Tipo de audiencia a programar:</strong>
		    			</td>
					    <td>
							<!--<input type="text" id="tipoAudienciaProgramarAudiencia" style="width: 170px; border: 0; background: #DDD;" readonly="readonly" />-->
							<select id="tipoAudienciaProgramarAudiencia" style="width:200px;"></select>
					    </td>
		    			<td colspan="3" rowspan="7" align="center" valign="bottom">
		    				<table id="gridAgendaPJENA"></table>
		    			</td>
		    			<td colspan="3" rowspan="7">
		    				<table id="gridSolicitudDeAudienciaJuecesPJENA"></table>
		    				<div id="divGridSolicitudDeAudienciaJuecesPJENA"></div>
		    			</td>
		  			</tr>
		  			<tr>
		    			<td align="right" valign="bottom">
		    				<strong>N�mero de Caso:</strong>
		    			</td>
		    			<td align="left" valign="bottom">
		    				<input type="text" id="numCasoProgramarAudiencia" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
		    			</td>
		  			</tr>
		  			<tr>
		    			<td align="right" valign="bottom">
		    				<strong>N�mero de Causa:</strong>
		    			</td>
		    			<td align="left" valign="bottom">
		    				<input type="text" id="numExpedienteProgramarAudiencia" style="width: 200px; border: 0; background: #DDD;" readonly="readonly"/>
		    			</td>
		  			</tr>
					<tr>
						<td align="right" valign="bottom">
							<strong>Fecha l&iacute;mite de audiencia:</strong>
						</td>
						<td align="left" valign="bottom">
							<input type="text" id="fechaLimiteProgramarAudiencia" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<strong>Fecha Seleccionada:</strong>
						</td>
						<td align="left" valign="bottom">
							<input type="text" id="fechaSeleccionadaAudiencia" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
						</td>
					</tr>
		  			<tr>
						<td align="right" valign="bottom">
							<strong>Duraci�n estimada de audiencia:</strong>
						</td>
		    			<td align="left" valign="bottom">
							<select id="duracionEstimadaProgramarAudiencia" style="width:200px;">
							   	<option value="0" >-Seleccione-</option>
			                	<option value="30">30 min.</option>
			                	<option value="60">1 hr. </option>
			                	<option value="90">1 hr. 30 min.</option>
			                	<option value="120">2 hrs.</option>
			                	<option value="150">2 hrs. 30 min.</option>
			                	<option value="180">3 hrs.</option>
			                	<option value="210">3 hrs. 30 min.</option>
			                	<option value="240">4 hrs.</option>
			                	<option value="270">4 hrs. 30 min.</option>
			                	<option value="300">5 hrs.</option>
			                	<option value="330">5 hrs. 30 min</option>
			                	<option value="360">6 hrs.</option>
			                	<option value="420">7 hrs.</option>
			                	<option value="480">8 hrs.</option>
			                	<option value="540">9 hrs.</option>
			                	<option value="600">10 hrs.</option>
			                	<option value="660">11 hrs.</option>
			                	<option value="720">12 hrs.</option>
			                	<option value="780">13 hrs.</option>
			                	<option value="840">14 hrs.</option>
							</select>
		    				<!--<input type="text" id="duracionEstimadaProgramarAudiencia" style="width: 170px; border: 0; background: #DDD;" readonly="readonly" />-->
	     				</td>
					</tr>
					<tr>
						<td align="right">
							<strong>Sala seleccionada:</strong>
						</td>
						<td>
							<input type="text" id="txtSalaSeleccionada" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							<strong>Hora de inicio:</strong>
						</td>
						<td>
							<input type="text" id="txtHoraInicioSeleccionada" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
						</td>
						<td width="102">
							<strong>
								<input type="text" size="4" style="width: 20px; border: 0; background: #669933;" readonly />
							</strong>Disponible
						</td>
						<td width="123">
							<strong>
								<input type="text" size="4" style="width: 20px; border: 0; background: red;" readonly />
							</strong>No Disponible
						</td>
						<td width="85">
							<input type="text" size="4" style="width: 20px; border: 0; background: #CCCCCC;" readonly />Inh&aacute;bil
						</td>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="6"><table id="gridsTd" width="100px"></table></td><td colspan="2"> <table id="gridsImputadosAudiencia" ></table><div id="pagerinv"></div> </td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3">&nbsp;</td>
						<td colspan="3">&nbsp;</td>
					</tr>
		 			<tr>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
					    <td colspan="3" align="center">
							<input type="button" id="btnGuardarAudiencia" class="btn_Generico" value="Guardar"  onclick="guardarAudiencia();"/>
					    </td>
		    			<td colspan="3" align="left">
		    				<input type="button" class="btn_Generico" id="btnDesignar" onclick="mostrarAsignarSalaTemporalPJENA();" value="Designar Sala Temporal" />
		    			</td>
		  			</tr>
		  			<tr>
                           <td colspan="7">&nbsp;</td>
					</tr>
					<tr>
                           <td colspan="7">&nbsp;</td>
					</tr>

				</table>

			</div>
			<!--Termina Sub Tab para audiencia  -->

			<!--Comienza Sub Tab para imputados -->
			<div id="tabschild-2">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
			            	<div id="divGridImputado1">
								<table id="gridImputado1"></table>
								<div id="paginadorGridImputado1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para imputados -->

			<!--Comienzan  Sub Tabs para la ceja de individualizacion -->
			<div id="tabschild-8">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridVictima1">
								<table id="gridVictima1"></table>
								<div id="paginadorGridVictima1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>

			<div id="tabschild-9">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridDenunciante1">
								<table id="gridDenunciante1"></table>
								<div id="paginadorGridDenunciante1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>

			<!--Comienza Sub Tab para Testigo -->
			<div id="tabschild-3">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
			            	<div id="divGridTestigo">
								<table id="gridTestigo1"></table>
								<div id="paginadorGridTestigo1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para Testigo -->

			<!--Comienza Sub Tab para Perito -->
			<div id="tabschild-4">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridPerito">
								<table id="gridPerito1"></table>
								<div id="paginadorGridPerito1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para Perito -->

			<!--Comienza Sub Tab para Policia Ministerial -->
			<div id="tabschild-5">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridPolicia1">
								<table id="gridPolicia1"></table>
								<div id="paginadorGridPolicia1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para Policia Ministerial -->

			<!--Comienza Sub Tab para fiscal -->
			<div id="tabschild-6">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridFiscal1">
								<table id="gridFiscal1"></table>
								<div id="paginadorGridFiscal1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para grid fiscal -->

			<!--Comienza Sub Tab para defensor -->
			<div id="tabschild-7">
				<table border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td>
							<div id="divGridDefensor1">
								<table id="gridDefensor1"></table>
								<div id="paginadorGridDefensor1"></div>
							</div>
			            </td>
			        </tr>
			        <tr>
			            <td>&nbsp;</td>
			        </tr>
			    </table>
			</div>
			<!--Termina Sub Tab para grid defensor -->

			<!--Comienza Sub Tab para objetos
			<div id="tabschild-3">
				<table>
					<tr>
						<td>
							<table width="200" border="0">
				 		 		<tr>
				    				<td>Objeto</td>
				    				<td>
				    					<input name="" type="text" id="campoObjeto"/>
				    				</td>
				  				</tr>
								<tr>
									<td>No. Prueba</td>
									<td>
										<input name="" type="text" id="campoPrueba"/>
									</td>
								</tr>
								<tr>
									<td>No. Cadena de Custodia</td>
									<td>
										<input name="" type="text" id="campoCadena"/>
									</td>
								</tr>
					  			<tr>
									<td>Descripcion Objeto</td>
									<td>
										<input name="" type="text" id="campoDescripciona"/>
									</td>
								</tr>
								<tr>
									<td>Estado</td>
									<td><select id="campoEstado"> </select> </td>
								</tr>
							</table>
								<input name="" type="button" value="Guardar Objeto" class="btn_modificar" onclick="guardaObjeto()"/>
						</td>
						<td>
							<table id="gridSolObjetos"></table>
							<div id="pagerGridSolObjetos" style="width: 300"></div>
						</td>
					</tr>
					<tr>
			             <td colspan="2">&nbsp;</td>
			        </tr>
				</table>
 			</div> -->
 			<!--Termina Sub Tab para objetos -->
		</div>
		<!--Termina sub cejas de programar audiencia-->

	</div>
	<!--Termina Tab programar audiencia-->

	<!--Comienza tab Administrar Actuaciones de Audiencia-->
	<div id="tabsDetalleAudiencias-6">

		<!--Comienza div para actuaciones -->
		<div id="divActuacionesCambioaBoton">

			<table width="720" border="0" align="center" cellpadding="0" cellspacing="5">
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Audiencia: </strong>
					</td>
					<td>
						<input type="text" id="audienciaAccPJENS" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" />
					</td>
					<td align="right">
						<strong>Tipo de Audiencia:</strong>
					</td>
					<td>
						<input type="text" id="tipoAudienciaAccPJENS" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" value="Juicio Oral" />
					</td>
				</tr>
				<tr>
					<td width="19%" align="right">
						<strong>Numero de Caso:</strong>
					</td>
					<td width="29%">
						<input type="text" id="numCasoAccPJENS"	style="width: 200px; border: 0; background: #DDD;" readonly="readonly" value="NSJPYUCPROC201100001" />
					</td>
					<td width="23%">
						<strong>Numero de Causa:</strong>
					</td>
					<td width="29%">
						<input type="text" id="numExpAccPJENS" style="width: 200px; border: 0; background: #DDD;" readonly="readonly" value="000001" /></td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
					<td align="right">
						<strong>Solicitar:</strong>
					</td>
					<td>
						<select id="solicitar">
							<option>Abogado Defensor</option>
						</select>
					</td>
					<td align="center">
						<input type="button" id="solicitarBoton" value="Solicitar" class="btn_Generico" />
					</td>
				</tr>
			</table>

		</div>
		<!--Comienza div para actuaciones -->

	</div>
	<!--Comienza tab Administrar Actuaciones de Audiencia-->


	<!--	Comienza Actuaciones-->
	<div id="tabsDetalleAudiencias-7">

		<table width="720" cellspacing="0" cellpadding="0">
			<tr>
				<td width="31">&nbsp;</td>
				<td width="314">&nbsp;</td>
				<td>&nbsp;</td>
				<td width="32">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="right">
					<strong>Seleccionar la opci�n deseada:</strong>
				</td>
				<!-- Enable IT se agregan Actuaciones cargadas desde BD -->
				<td id="tdCbxAccionesTab">
					<select id="cbxAccionesTab">
						<option value="-1">-Seleccione-</option>
					</select>
				</td>
				<!-- <td>
					<select id="finalAudienciaOpcion">
						<option value="0">-Seleccione-</option>
						<option value="1">Generar Acta de Audiencia</option>
								Hay que checar funcionamiento
						<option value="2">Solicitar copia de Audio y Video</option>
						<option value="3">Solicitar Transcripcion de audiencia</option>
						<option value="4">Solicitar traslado de imputado</option>
					</select>
				</td> -->
				<td>
<!-- 				/*se reemplaza funcion 'finalizarAudiencia' por 'validaAudiencia' para saber el estatus de la audiencia/*Enable IT ByYolo*/ -->
					<input type="button" class="btn_Generico" value="Finalizar Audiencia" onclick="validaAudiencia();" id="btnFinalizarAudiencia">
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
 			<tr>
    			<td>&nbsp;</td>
				<td colspan="2">
			    	<div id="divGernerarActa" style="display: none;">
			    		<table>
			    			<tr>
			    				<td></td>
			    			</tr>
			    		</table>
			    	</div>
			    	<div id="divSolicitarCopia" style="display: none;">
			    		<table>
			    			<tr>
			    				<td></td>
			    			</tr>
			    		</table>
			    	</div>
			    	<div id="divSolicitarTranscripcion" style="display: none;">
			    		<table>
			    			<tr>
			    				<td>solicitar Transcripcion</td>
			    			</tr>
			    		</table>
			    	</div>
			    	<div id="divSolicitarTraslado" style="display: none;">
			    		<table>
			    			<tr>
			    				<td>
			    					<table width="720" border="0" align="center" cellpadding="0" cellspacing="5">
										<tr>
											<td colspan="4" align="right">
												<table id="gridTrasladoPJA"></table>
												<div  id="pager2"></div>
											</td>
										</tr>
										<tr>
											<td colspan="4" align="right">&nbsp;</td>
										</tr>
										<tr>
											<td colspan="2" align="center">
										  		<input type="button" value="Enviar" id="trasladoImputado"  class="btn_Generico"/>
											</td>
										    <td colspan="2" align="center">
										    	<input type="button" value="Cancelar" id="trasladoImputado"  class="btn_Generico"/>
											</td>
										</tr>
										<tr>
											<td colspan="4" align="right">&nbsp;</td>
										</tr>
									</table>

            						<div id="poponTraslados" style="display: none;">
										<table width="745" border="0">
            								<tr>
											    <td colspan="2" align="right">Nombre de la Persona a Trasladar:</td>
											    <td colspan="2">&nbsp;&nbsp;
											    	<input name="textfield7" type="text" disabled="disabled" id="textfield7" />
											    </td>
											</tr>
											<tr align="right">
												<td width="187">Lugar de Origen:</td>
											    <td width="176">
											    	<label>
											      		<input name="textfield" type="text" disabled="disabled" id="textfield" />
											    	</label>
											    </td>
											    <td width="183">Lugar Destino:</td>
											    <td width="181">
											    	<input name="textfield2" type="text" disabled="disabled" id="textfield2" />
											    </td>
  											</tr>
											<tr align="right">
												<td>Funcionario que Autoriza:</td>
												<td>
													<input name="textfield3" type="text" disabled="disabled" id="textfield3" />
												</td>
												<td>Fecha de Presentacion:</td>
												<td>
													<input name="textfield4" type="text" disabled="disabled" id="textfield4" />
												</td>
											</tr>
											<tr align="right">
												<td>Hora de Presentacion:</td>
												<td>
													<input name="textfield5" type="text" disabled="disabled" id="textfield5" />
												</td>
												<td>Duracion de Presentacion:</td>
												<td>
													<input name="textfield6" type="text" disabled="disabled" id="textfield6" />
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
    			<td>&nbsp;</td>
  			</tr>
		</table>

	</div>
	<!--	Termina Actuaciones-->
	<!-- Enable IT ocultando pesta�a Administrar Recurso -->
<!-- 	<div id="tabsDetalleAudiencias-8">
	<table width="75%" border="0">
  <tr>
    <td width="20%" align="right">Caso:</td>
    <td width="27%"><label>
      <input type="text" name="textCaso" id="textCaso" size="30" readonly="readonly" border="0" style="background: #DDD"/>
    </label></td>
    <td width="26%"  align="right">Fecha:</td>
    <td width="27%"><input type="text" name="textFecha" id="textFecha" size="30" readonly="readonly" border="0" style="background: #DDD"/></td>
  </tr>
  <tr>
    <td  align="right">Causa:</td>
    <td><input type="text" name="textCausa" id="textCausa" size="30" readonly="readonly" border="0" style="background: #DDD"/></td>
    <td width="26%"  align="right">Tipo de Recurso:</td>
    <td><label>
      <select name="select" id="selectTRecurso" style="white:20">
      	<option>- Seleccionar -</option>
      	<option> Apelaci�n </option>
      	<option> Casaci�n </option>
      	<option> Queja </option>
      	<option> Revocaci�n </option>
      	<option> Revisi�n </option>
      </select>
    </label></td>
  </tr>
  <tr>
    <td  align="right">Toca:</td>
    <td><input type="text" name="textToca" id="textToca" size="30" readonly="readonly" border="0" style="background: #DDD"/></td>
    <td  align="right">Hora:</td>
    <td  ><input type="text" name="textHora" id="textHora" size="30" readonly="readonly" border="0" style="background: #DDD"/></td>
    <td  align="right">Resoluci&oacute;n</td>
    <td><select name="select2" id="selectResolutivo" style="white:20">
     	<option>- Seleccionar -</option>
     	<option> Admisi�n </option>
     	<option> Anulaci�n </option>
     	<option> Confirmaci�n </option>
     	<option> Modificaci�n </option>
     	<option> Ratificaci�n </option>
     	<option> Rechazo </option>
     	<option> Revocaci�n </option>
      </select></td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td  align="right"><label>
      <input type="submit" name="button" id="button" value="Guardar"  class="btn_Generico" onclick="guardarRR()"/>
    </label></td>
  </tr>
</table>
	</div> -->
   <!--COMIENZA TAB AMPAROS-->
       <div id="tabs-10" class="tabTabsAmparos">
   		<jsp:include page="/consultarAmparo.jsp"></jsp:include>
	</div>
	<!--TERMINA TAB AMPAROS-->

	<div id="tabs-11" class="tabTabsDocs">
		<br>
			<table id="gridDetalleFrmPrincipal"></table>
			<div id="pager1Documentos"></div>
			<form name="frmDoc3" action="<%= request.getContextPath() %>/ConsultarContenidoArchivoDigital.do" method="post">
				</form>
				<form name="frmDoc2" action="<%= request.getContextPath() %>/GenerarDocumentoDirecto.do" method="post">
					<input type="hidden" name="formaId" />
					<input type="hidden" name="numeroUnicoExpediente" />
				</form>
			<table id="tableDocs">
				<tr>
					<td>Total de documentos:</td>
					<td id="idTotalDocumentos">&nbsp;</td>
				</tr>
			</table>
		</div>


	<!--COMIENZA TAB NOTIFICACIONES-->
    <div id="tabNotificaciones-12" class="notificaciones">
		<jsp:include page="/WEB-INF/paginas/NotificacionesIncludeView.jsp" flush="true"></jsp:include>
	</div>
	<!--TERMINA TAB NOTIFICACIONES-->


</div>



<!--Terminan los Tabs-->

<!--Comienza div para agregar destinatario-->
<div id="agregarDestinatario" style="display: none">
	<table width="800px" cellspacing="0" cellpadding="0">
		<tr>
			<td width="62">&nbsp;</td>
			<td colspan="5">&nbsp;</td>
		</tr>
		<tr>
			<td height="28">Nombre:</td>
			<td width="199">
				<input type="text" size="30" id="nombre" onkeypress="return soloLetrasNPunto(event,this.id);"/>
			</td>
			<td width="72">Instituci�n:</td>
			<td width="127">
				<select name="select" id="cmbInstitucion">
					<option value="Defensoria">Defensoria</option>
					<option value="Ministerio P�blico">Ministerio P�blico</option>
				</select>
			</td>
			<td width="143">Direcci�n Electronica:</td>
			<td width="195">
				<input type="text" size="30" id="correo"/>
			</td>
		</tr>
		<tr>
			<td height="30" >Apellido Paterno:</td>
			<td><input type="text" size="30" id="apellidoPaterno" onkeypress="return soloLetrasNPunto(event,this.id);"/></td>
			<td>Apellido Materno:</td>
			<td><input type="text" size="30" id="apellidoMaterno" onkeypress="return soloLetrasNPunto(event,this.id);"/></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td height="28" valign="top">&nbsp;</td>
			<td colspan="5">&nbsp;</td>
		</tr>
		<tr>
			<td height="28" valign="top">Direcci�n Fis�ca:</td>
			<td colspan="5">
				<jsp:include page="ingresarDomicilioView.jsp"></jsp:include>
			</td>
		</tr>
	</table>
</div>
<!--Termina div para agregar destinatario-->

<!--Comienza Solicitar defensor-->
<div  id="divSolicitarDefensor" style="display:none">
	<table width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2" rowspan="2">
			  	<table cellspacing="0" cellpadding="0" id="ListaImputados"></table>
				<div id="paginadorListaImputados"></div>
			</td>
    		<td>&nbsp;</td>
  		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
	</table>
</div>
<!--Termina Solicitar defensor-->

<!--Comienza Div Agregar resolutivo-->
<div  id="divAgregarResolutivo" style="display: none">
	<table width="500" border="0">
	  <tr>
	    <td width="25">&nbsp;</td>
	    <td width="450">
			<strong>Temporizador de Video:</strong>
		</td>
	    <td width="25">&nbsp;</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td align="center">
			<input name="text" type="text" id="tempVideo" style="width:150px; border: 0; background:#DDD;"/>
		</td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td>
			<strong>Resolutivo:</strong>
		</td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	    <td align="center">
	    <!-- eNABLE IT: Se permite la captura de 7500 caracteres y se agrega funcionalidad (funcion) -->
			<!-- <textarea name="textarea" cols="50" rows="10" id="resolutivo" onkeyup="return ismaxlength(this,200)"></textarea> -->
			<textarea name="textarea" cols="50" rows="10" id="resolutivo"  maxlength="7500" onkeyup="return ismaxlength2(this)"></textarea>

		</td>
	    <td>&nbsp;</td>
	  </tr>
	</table>
</div>
<!--Termina Div Agregar resolutivo-->

<!--	Comienza div para agregar funcionario-->
<div id="divIngresarFuncionario" style="display: none">
	<table width="415" cellspacing="0" cellpadding="0">
	    <tr>
	        <td width="144">&nbsp;</td>
	        <td width="253">&nbsp;</td>
	        <td width="16">&nbsp;</td>
	    </tr>
	    <tr>
	        <td colspan="3" align="center"><strong>Datos del funcionario</strong></td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Seleccionar Funcionario:</strong></td>
	        <td>
	            <select id="cbxFuncionarioPJENS" style="width:240px"></select>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Nombre:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="nombreFuncionarioPJENS" onkeypress="return soloLetrasDos(event,this.id);"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Apellido Paterno:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="apPatFuncionarioPJENS" onkeypress="return soloLetrasDos(event,this.id);"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Apellido Materno:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="apMatFuncionarioPJENS" onkeypress="return soloLetrasDos(event,this.id);"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right">&nbsp;</td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	    </tr>
	</table>
</div>
<!--	Termina div para agregar funcionario-->

<!--	Comienza div para agregar funcionario-->
<div id="divIngresarFuncionarioSig" style="display: none">
	<table width="415" cellspacing="0" cellpadding="0">
	    <tr>
	        <td width="144">&nbsp;</td>
	        <td width="253">&nbsp;</td>
	        <td width="16">&nbsp;</td>
	    </tr>
	    <tr>
	        <td colspan="3" align="center"><strong>Datos del funcionario</strong></td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Seleccionar Funcionario:</strong></td>
	        <td>
	            <select id="cbxFuncionarioSigPJENS" style="width:240px"></select>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Nombre:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="nombreFuncionarioSigPJENS"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Apellido Paterno:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="apPatFuncionarioSigPJENS"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right"><strong>Apellido Materno:</strong></td>
	        <td align="left">
	            <input type="text" class="" size="40" maxlength="40" id="apMatFuncionarioSigPJENS"/>
	        </td>
	        <td>&nbsp;</td>
	    </tr>
	    <tr>
	        <td align="right">&nbsp;</td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	    </tr>
	</table>
</div>
<!--	Termina div para agregar funcionario-->


<!--Comienza Form para abrir documento-->
<form name="frmDoc" action="<%= request.getContextPath()%>/abrirPDF.do" method="post">
	<input type="hidden" name="idLey" value=""/>
	<input type="hidden" name="nombreArchivo" value=""/>
</form>
<!--Termina Form para abrir documento-->






<!---------------------------------------------------Comienzan divs para ventanas modales------------------------------------------------------------------>

	<!--Comienza div agregar dato de prueba-->
	<div  id="divAgregarDatoDePrueba" style="display: none">

		<table width="440" cellspacing="0" cellpadding="0" border="0">
	      <tr>
	        <td width="5">&nbsp;</td>
	        <td width="230" align="right">&nbsp;</td>
	        <td width="200">&nbsp;</td>
	        <td width="5">&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	            <strong>Tipo de dato de prueba:</strong>
	        </td>
	        <td>
	            <select id="tipoDatoPruebaPJENS" style="width:200px">
	              <option value="0">-Seleccione-</option>
	              <option value="1">Documento</option>
	              <option value="2">Objeto</option>
	            </select>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	            <div id="etiTipoObjetoDatoPruebaPJENS">
	                <strong>Tipo de Objeto:</strong>
	            </div>
	        </td>
	        <td>
	            <div id="divCbxTipoObjetoDatoPruebaPJENS">
	                <select id="cbxTipoObjetoDatoPruebaPJENS" style="width:200px">
	              	</select>
	            </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiNombreDatoPruebaPJENS">
	        		<strong>Nombre del dato:</strong>
	        	</div>
	        </td>
	        <td>
	        	<div id="divTxtNombreDatoPruebaPJENS">
	        		<input type="text" id="txtNombreDatoPruebaPJENS"  maxlength="30" size="30" style="width:210px"/>
	        	</div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiNumIdeDatoPruebaPJENS">
	            	<strong>N&uacute;mero de identificaci&oacute;n:</strong>
	            </div>
	        </td>
	        <td>
	        	<div id="divTxtNumeroIdeDatoPruebaPJENS">
	        		<input type="text" id="txtNumeroIdeDatoPruebaPJENS" maxlength="20" style="width:210px"/>
	        	</div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiRccDatoPruebaPJENS">
	            	<strong>Reg. Cadena de custodia:</strong>
	            </div>
	        </td>
	        <td>
	        	<div id="divTxtRccDatoPruebaPJENS">
	        		<input type="text" id="txtRccDatoPruebaPJENS" maxlength="30" size="30" style="width:210px"/>
	        	</div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiDescripcionPJENS">
	        		<strong>Descripci�n:</strong>
	        	</div>
	        </td>
	        <td>
	        	<div id="divTxtAreaDescripcionDatoPruebaPJENS">
	        		<textarea cols="33" rows="6" id="txtAreaDescripcionDatoPruebaPJENS" onkeyup="return ismaxlength(this,200)" style="width:215px"></textarea>
	        	</div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	    </table>

	</div>
	<!--Termina div agregar dato de prueba-->

	<!--Comienza div rechazar dato de prueba-->
	<div id="divRechazarDatoDePruebaPJENS" style="display: none">
		<table width="400" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="14">&nbsp;</td>
	        <td width="374">&nbsp;</td>
	        <td width="12">&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td height="200" align="center" valign="middle">
	        	<textarea id="motivoRechazoDatoPrueba" cols="60" rows="12"></textarea>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	    </table>
	</div>
	<!--Termina div rechazar dato de prueba-->


	<!--Comienza div Relacionar Medios de Prueba-->
	<div id="divRelacionarMediosDePruebaPJENS" style="display: none">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td width="150">&nbsp;</td>
		    <td width="300">&nbsp;</td>
		    <td colspan="2">&nbsp;</td>
		  </tr>
		  <tr>
		    <td height="250" colspan="4">
		    	<table  id="gridRelacionarMediosDePruebaPJENS" width="100%"></table>
				<div id="pagerGridRelacionarMediosDePruebaPJENS"></div>
		    </td>
		  </tr>
		</table>
	</div>
	<!--Relacionar div Relacionar Medios de Prueba-->

	<!--Comienza div Relacionar Medios de Prueba-->
	<div id="divAsociarDatoDePruebaPJENS" style="display: none">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td width="150">&nbsp;</td>
		    <td width="300">&nbsp;</td>
		    <td colspan="2">&nbsp;</td>
		  </tr>
		  <tr>
		    <td height="250" colspan="4">
		    	<table  id="gridAsociarDatoDePruebaPJENS" width="100%"></table>
				<div id="pagerGridAsociarDatoDePruebaPJENS"></div>
		    </td>
		  </tr>
		</table>
	</div>
	<!--Relacionar div Relacionar Medios de Prueba-->

	<!--Comienza div agregar Medio de prueba-->
	<div  id="divAgregarMedioDePrueba" style="display: none">

		<table width="440" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="5">&nbsp;</td>
	        <td width="230" align="right">&nbsp;</td>
	        <td width="200">&nbsp;</td>
	        <td width="5">&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<strong>Tipo de Medio de Prueba:</strong>
	        </td>
	        <td>
	            <select name="tipoMediaPruebaPJENS" id="tipoMediaPruebaPJENS" style="width:200px">
	              <option value="0">-Seleccione-</option>
	              <option value="1">Documento</option>
	              <option value="2">Persona</option>
	            </select>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiSubTipoDocumentoMedioPruebaPJENS">
			    	<strong>*Subtipo del documento:</strong>
		        </div>
<!--	            <div id="etiCalidadPersonaMedioPruebaPJENS">-->
<!--			    	<strong>Calidad:</strong>-->
<!--			    </div>-->
	        </td>
	        <td>
	        	<div id="divSubTipoDocumentoMedioPruebaPJENS">
	                <select id="cbxSubTipoDocumentoMedioPruebaPJENS" style="width:200px">
	                  <option value="0">-Seleccione-</option>
	                  <option value="2">Archivo de audio</option>
	                  <option value="1">Archivo de texto</option>
	                  <option value="3">Archivo de video</option>
	                  <option value="4">Im�genes/Fotograf�as</option>
	                </select>
	            </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiNombreDocumentoMedioPruebaPJENS">
			    	<strong>*Nombre del documento:</strong>
			    </div>
	        </td>
	        <td>
	        	<div id="divTxtNombreDocumentoMedioPruebaPJENS">
			    	<input type="text" id="txtNombreDocumentoMedioPruebaPJENS" maxlength="20" style="width:200px"/>
			    </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	       		<div id="etiNumeroIdeDocumentoMedioPruebaPJENS">
			    	<strong>*N&uacute;mero de identificaci&oacute;n:</strong>
			    </div>
	        </td>
	        <td>
	        	<div id="divNumeroIdeDocumentoMedioPruebaPJENS">
			    	<input type="text" id="txtNumeroIdeDocumentoMedioPruebaPJENS"  maxlength="20" style="width:200px"/>
			    </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiAdjuntarDocumentoMedioPruebaPJENS">
			    	<span class="au av ra rc ta" ><strong>*Adjuntar:</strong></span>
			    </div>
	        </td>
	        <td>
	        	<div id="divTxtAdjuntarDocumentoMedioPruebaPJENS">
					<div id="divAdjuntarDoc" class="au av ra rc ta">

				        	<form id="medioPruebaForm" name="medioPruebaForm"
				        	action="<%= request.getContextPath() %>/agregarMedioPrueba.do" method="post" enctype="multipart/form-data">
								<input type="file" name="archivoAdjunto" id="archivoPorSubir">
								<input type="hidden" name="datoPruebaId"/>
								<input type="hidden" name="audienciaId"/>
								<input type="hidden" name="tipoMedioPrueba"/>
								<input type="hidden" name="subTipoMedioPrueba"/>
								<input type="hidden" name="nombreDoc"/>
								<input type="hidden" name="numIdDoc"/>
								<input type="hidden" name="refUbicacionFisica"/>
								<input type="hidden" name="descDocumento"/>
								<input type="hidden" name="numeroExpediente"/>
							</form>
					</div>
			    </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiRefUbicacionDocumentoMedioPruebaPJENS">
			    	<strong>Ref. ubicaci�n f�sica:</strong>
			    </div>
	        </td>
	        <td>
	        	<div id="divTxtRefUbicacionFisicaMedioPruebaPJENS">
			    	<input type="text" id="txtRefUbicacionFisicaMedioPruebaPJENS" style="width:200px"/>
			    </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td align="right">
	        	<div id="etiDescripcionDocMedioPruebaPJENS">
			    	<strong>*Descripci�n:</strong>
			    </div>
	        </td>
	        <td>
	        	<div id="divTxtAreaDescripcionDocMedioPruebaPJENS">
			    	<textarea cols="31" rows="5" id="txtAreaDescripcionDocMedioPruebaPJENS"></textarea>
			    </div>
	        </td>
	        <td>&nbsp;</td>
	      </tr>
	    </table>

	</div>
	<!--Termina div agregar Medio de prueba Documento-->

<!--Terminan divs para ventanas modales de pruebas-->
	<form name="frmDococumentos" action="<%= request.getContextPath() %>/ConsultarContenidoArchivoDigital.do" method="post">
		<input type="hidden" name="documentoId" />
	</form>

	<!-- div para el alert dinamico -->
	<div id="dialog-Alert" style="display: none">
		<table align="center">
			<tr>
				<td align="center"><span id="divAlertTexto"></span></td>
			</tr>
		</table>
	</div>

	<!-- div para el alert dinamico antes de cerrar ventana -->
	<div id="dialog-AlertApplet" style="display: none">
		<table align="center">
			<tr>
	  			<td>
		    		<div align="center">Introduzca la ruta donde se alojaran los videos:</div>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    			<div align="center"><input type="text" id="dir" style="width:300px" tabindex="1" maxlength="300"/></div>
	    		</td>
	    	</tr>
     	</table>
	</div>

	<!--Comienza div Relacionar Involucrados a la audiencia siguiente-->
	<div id="divRelacionarInvolucradosPorCalidadAudienciaSig" style="display: none" align="center">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td height="250" colspan="4" align="center">
				<table  id="gridRelacionarInvolucradosPorCalidadAudienciaSig" width="90%"></table>
				<div id="pagerGridRelacionarInvolucradosPorCalidadAudienciaSig"></div>
		    </td>
		  </tr>
		</table>
	</div>
	<!--Relacionar div Relacionar Medios de Prueba-->


	<form id="frmRecargaVisor"
		  name="frmRecargaVisor" action="<%=request.getContextPath()%>/recargaVisor.do"
		  method="post" enctype="multipart/form-data">

		<input type="hidden" name="idAudiencia" />
		<input type="hidden" name="idVisor" />
		<input type="hidden" name="idAudienciaSiguiente" />
	</form>
</body>
</html>