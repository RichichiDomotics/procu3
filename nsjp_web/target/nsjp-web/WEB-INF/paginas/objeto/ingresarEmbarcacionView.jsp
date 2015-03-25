<%@page import="mx.gob.segob.nsjp.comun.enums.elemento.TipoElemento"%>
<%@ page import="org.omg.CORBA.Request"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mx.gob.segob.nsjp.dto.usuario.UsuarioDTO"%>
<%@ page import="mx.gob.segob.nsjp.comun.enums.configuracion.Parametros"%>
<%@ page import="mx.gob.segob.nsjp.comun.enums.seguridad.Roles" %>
<%@ page import="mx.gob.segob.nsjp.dto.configuracion.ConfiguracionDTO"%>
<%@ page import="mx.gob.segob.nsjp.web.base.action.GenericAction"%>
<%@ page import="mx.gob.segob.nsjp.comun.enums.catalogo.EntidadFederativa"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ingresar Embarcaci&oacute;n</title>
	<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/jquery.windows-engine.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath()%>/resources/css/estilos.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/resources/css/ui-lightness/jquery-ui-1.8.11.custom.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/layout_complex.css" media="screen" />
	

	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/estilos.css" media="screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/resources/css/multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/resources/css/multiselect/style.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/resources/css/multiselect/prettify.css" />
	<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-1.5.1.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-ui-1.8.10.custom.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bloqueaTecla.js"></script>
	<script src="<%=request.getContextPath()%>/js/prettify.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
	
	<script src="<%=request.getContextPath()%>/js/comun.js"></script>
	<script src="<%=request.getContextPath()%>/js/objetos.js"></script>
	
	<%
	String rolActivo = "";
	UsuarioDTO usuario = (UsuarioDTO) request.getSession().getAttribute("KEY_SESSION_USUARIO_FIRMADO"); 
	if (usuario != null 
			&& usuario.getRolACtivo() != null 
			&& usuario.getRolACtivo().getRol() != null
			&& usuario.getRolACtivo().getRol().getRolId() != null){
		rolActivo = usuario.getRolACtivo().getRol().getRolId().toString();
	}
	%>
		
	<script type="text/javascript">
	
	var idEmbarcacion="";
	var tipoObjeto="";
	var numeroExpediente="";
	var cadenaCustodia="";
	var fechaLevCadCus="";
	var origenEvdCadCus="";
	var deshabilitarCampos = window.parent.deshabilitarCamposPM;
	var ocultaAnularObjetoCadCus=null;
	
	var contextoPagina = "${pageContext.request.contextPath}";
	
	var esModoConsulta = '<%= request.getParameter("esModoConsulta")%>';
	var rolActivo = '<%=rolActivo%>';
	var entidadFedYuc = '<%=EntidadFederativa.YUCATAN.getValorId()%>';

	jQuery().ready(			
		function () {
			//Instruccion pensada solo para el caso de policia ministerial
			if(deshabilitarCampos == true){
				$(":enabled").attr('disabled','disabled');
			}	
			
			if(esModoConsulta != null && esModoConsulta == '1'){
				$(":enabled").attr('disabled','disabled');
				$('input[type="submit"]').hide();
				$('input[type="button"]').hide();
			}
			
			numeroExpediente='<%= request.getParameter("numeroExpediente")%>';
			idEmbarcacion='<%= request.getParameter("idEmbarcacion")%>';
			cadenaCustodia='<%= request.getParameter("cadenaCustodia")%>';
			fechaLevCadCus='<%= request.getParameter("fechaLevCadCus")%>';
			origenEvdCadCus='<%= request.getParameter("origenEvdCadCus")%>';
			
			if (idEmbarcacion != null && idEmbarcacion != 0)
				$("#imgConFoto").attr("src",'<%=request.getContextPath()%>/obtenImagenDeElemento.do?elementoID=<%= request.getParameter("idEmbarcacion")%>');
			else{
				$("#imgConFoto").attr("src","<%=request.getContextPath()%>/resources/images/Foto.JPG");
			}
			
			if(idEmbarcacion=='null')
			{
				idEmbarcacion=0;	
			}
			tipoObjeto='<%= request.getParameter("tipoObjeto")%>';
			
			cargaTiposEmbarcacion();
			$('#cbxTipoEmbarcacion').change(cargaMarcasEmbarcacion);
			$('#cbxMarcaEmbarcacion').change(cargaSubMarcasEmbarcacion);
			cargaColores();
			cargaPaises();
			cargaCondicion();
			cargaRelacionesHecho('<%=((ConfiguracionDTO) request.getSession().getAttribute(GenericAction.KEY_SESSION_CONFIGURACION_GLOBAL)).getEntidadFederativaDespliegueId() %>');
			var num=parent.num;
			

			//lineas para ocultar la opcion de anular objeto alconsultar desde una cadena de custodia
			//Viene con valor a 1 desde asentarRegCadenaCustodiaView.jsp
			//No es setteado en el menu intermedio
			ocultaAnularObjetoCadCus='<%= request.getParameter("anularConsultaCadCus")%>';
			
			if(parseInt( ocultaAnularObjetoCadCus ) ==1)
			{
				$("#anularElemento").hide("");
				$("#anularInv").hide("");
				if(idEmbarcacion!=null && idEmbarcacion!=0){
					$(":enabled").attr('disabled','disabled');
					$('input[type="submit"]').hide();
					$('input[type="button"]').hide();
				}
			}
			

			//revisamos si es una consulta
			if(idEmbarcacion!=null && idEmbarcacion!=0)
			{
				consultaEmbarcacion();
				//condicional para no mostrar el boton de anular objeto cuando entramos desde cadena de custodia
				if(parseInt( ocultaAnularObjetoCadCus ) ==1)
				{
					$("#anularElemento").hide("");
					$("#anularInv").hide("");
				}
				else
				{
					$("#anularElemento").show("");
					$("#anularInv").show("");
				}
			}
			else
			{
				if(num!=null && num!="0"){
					$("#anularElemento").hide();
					$("#anularInv").hide();
				}
			}
			
			if (rolActivo == '<%=Roles.COORDINADORAMPGENERAL.getValorId()%>'){
				$(":enabled").attr('disabled','disabled');
				$('input[type="submit"]').hide();
				$('input[type="button"]').hide();
			}
	});
	
	/*
	*Funcion para mandar consultar la embarcacion
	*/
	function consultaEmbarcacion()
	{
		$.ajax({
    		type: 'POST',
    		url: '<%=request.getContextPath()%>/ConsultaObjetoPorId.do',
    		data: 'idObjeto='+idEmbarcacion,
    		dataType: 'xml',
    		async: false,
    		success: function(xml){
    			if(parseInt($(xml).find('code').text())==0)
	    		{
    				//seteamos la informacion del hecho
    				$(xml).find('EmbarcacionDTO').each(function(){
    							seteaDatosEmbarcacion($(this));
		    	      });
	    		}
    		}	
    	});
	}
	
	function seteaDatosEmbarcacion(xml)
	{
		$('#cbxTipoEmbarcacion').find("option[value='"+$(xml).find('tipoEmbarcacion').find('idCampo').text()+"']").attr("selected","selected");
		cargaMarcasEmbarcacion();
		$('#cbxMarcaEmbarcacion').find("option[value='"+$(xml).find('marca').find('idCampo').text()+"']").attr("selected","selected");
		cargaSubMarcasEmbarcacion();
		$('#cbxSubMarcaEmbarcacion').find("option[value='"+$(xml).find('subMarca').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxColorEmbarcacion').find("option[value='"+$(xml).find('color').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxPaisOrigenEmbarcacion').find("option[value='"+$(xml).find('paisOrigen').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxCondicionEmbarcacion').find("option[value='"+$(xml).find('valorByCondicionFisicaVal').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxRelacionHecho').find("option[value='"+$(xml).find('relacionHechoVal').find('idCampo').text()+"']").attr("selected","selected");
		$('#txtNombreEmbarcacion').val($(xml).find('nombreEmbarcacion').text());
		$('#txtNoMotorEmbarcacion').val($(xml).find('noMotor').text());
		$('#txtNoSerieEmbarcacion').val($(xml).find('noSerie').text());
		$('#txtMatriculaEmbarcacion').val($(xml).find('matricula').text());
		if($(xml).find('almacen'))
			$(xml).find('almacen').remove();
		$('#txtBoxDescEmbarcacion').val($(xml).find('descripcion').text());
	}

   /**
	*Funcion que limpia los combos que dependen del combo tipo de embarcacion
	*/
	function limpiaCombosDependsTipo(){
		$('#cbxMarcaEmbarcacion').empty();
		$('#cbxMarcaEmbarcacion').append('<option value="-1">-Seleccione-</option>');	//Por default seleccione
		$('#cbxSubMarcaEmbarcacion').empty();
		$('#cbxSubMarcaEmbarcacion').append('<option value="-1">-Seleccione-</option>');	//Por default seleccione
	}


	/**
	*Funcion que limpia los combos que dependen del combo tipo de la marca de la embarcacion
	*/
	function limpiaCombosDependsMarca(){
		$('#cbxSubMarcaEmbarcacion').empty();
		$('#cbxSubMarcaEmbarcacion').append('<option value="-1">-Seleccione-</option>');	//Por default seleccione
	}
		

	/*
	*Funcion que realiza la carga del combo de tipos de embarcacion
	*/
	function cargaTiposEmbarcacion() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarTiposEmbarcacion.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catTiposEmbarcacion').each(function(){
					$('#cbxTipoEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

	
	/*
	*Funcion que realiza la carga del combo de marcas de embarcacion
	*/
	function cargaMarcasEmbarcacion() {

		var selected = $("#cbxTipoEmbarcacion option:selected");
		
		limpiaCombosDependsTipo();
		
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarMarcasEmbarcacion.do',
			data: 'glTipoEmbarcacionId='+selected.val(),
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catMarcasEmbarcacion').each(function(){
					$('#cbxMarcaEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
					$('#cbxMarcaEmbarcacion').multiselect('refresh');
				});
			}
		});
	}

	/*
	*Funcion que realiza la carga de  sub marcas de embarcacion
	*/
	function cargaSubMarcasEmbarcacion() {

		var selected = $("#cbxMarcaEmbarcacion option:selected");

		limpiaCombosDependsMarca();
		
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarSubMarcasEmbarcacion.do',
			data: 'glMarcaEmbarcacionId=' + selected.val(),
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catSubMarcasEmbarcacion').each(function(){
					$('#cbxSubMarcaEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
					$('#cbxSubMarcaEmbarcacion').multiselect('refresh');
				});
			}
		});
	}



	
	/*
	*Funcion que realiza la carga de colores de la embarcacion
	*/
	function cargaColores() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarColores.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catColores').each(function(){
					$('#cbxColorEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

	
	/*
	*Funcion que realiza la carga del combo de Paises
	*/
	function cargaPaises() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/cargarPaises.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catPaises').each(function(){
					$('#cbxPaisOrigenEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

	
	/*
	*Funcion que realiza la carga de la condicion de la embarcacion
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
					$('#cbxCondicionEmbarcacion').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}	


	
//	COMIENZA FUNCIONES PARA EL GUARDADO DE LOS DATOS		
	function obtenerValoresEmbarcacion(){		
		var paramEmbarcacion = "idEmbarcacion="+idEmbarcacion; 
		paramEmbarcacion += '&glTipoEmbarcacionId=' + $("#cbxTipoEmbarcacion option:selected").val();		
		paramEmbarcacion += '&glMarcaEmbarcacionId=' +  $("#cbxMarcaEmbarcacion option:selected").val();
		paramEmbarcacion += '&glSubMarcaEmbarcacionId=' + $("#cbxSubMarcaEmbarcacion option:selected").val();
		paramEmbarcacion += '&glColorEmbarcacionId=' + $("#cbxColorEmbarcacion option:selected").val();
		paramEmbarcacion += '&glPaisEmbarcacionId=' + $("#cbxPaisOrigenEmbarcacion option:selected").val();
		paramEmbarcacion += '&gcNombreEmbarcacion=' + $('#txtNombreEmbarcacion').val();
		paramEmbarcacion += '&gcNoMotorEmbarcacion=' + $('#txtNoMotorEmbarcacion').val();
		paramEmbarcacion += '&gcNoSerieEmbarcacion=' + $('#txtNoSerieEmbarcacion').val();
		paramEmbarcacion += '&gcMatriculaEmbarcacion=' + $('#txtMatriculaEmbarcacion').val();		
		paramEmbarcacion += '&glCondicionFisica=' + $("#cbxCondicionEmbarcacion option:selected").val();
		paramEmbarcacion += '&gcDescripcion=' + $("#txtBoxDescEmbarcacion").val();
		paramEmbarcacion += '&relacionHechoId=' + $("#cbxRelacionHecho option:selected").val();
		
		if(cadenaCustodia!='null')
		{
			paramEmbarcacion += '&cadenaCustodia=' + cadenaCustodia;
			paramEmbarcacion += '&origenEvdCadCus=' + origenEvdCadCus;
			paramEmbarcacion += '&fechaLevCadCus=' + fechaLevCadCus;
		}
		
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/ingresarEmbarcacion.do?numeroExpediente='+numeroExpediente +'',
			data: paramEmbarcacion,
			dataType: 'xml',
			success: function(xml){
			  var tipoEmbarcacion = $("#cbxTipoEmbarcacion option:selected").text();
			  var id = $(xml).find('EmbarcacionForm').find('glTipoEmbarcacionId').text();
			  
			  //Se ha agregado nuevo elemento
			  if(idEmbarcacion==0 && id>0)
			  {	
				//Se valida si se ha ingresado una imagen nueva
				  if (document.frmImagenElemento.archivo.value != ''){
					  //Para guardar la imagen
					  enviaImagenDeElemento(id);  
				  } 
				  
				  //Desde asentarRegCadenaCustodiaView.jsp 
				  if(parseInt( ocultaAnularObjetoCadCus ) == 1){
					  alertDinamico("Se guard� correctamente la informaci�n");
					  regresarControlCadenaCustodia();
					  //customAlert("Se guard� correctamente la informaci�n", '', regresarControlCadenaCustodia);
				  }else //Desde el ingresarMenuIntermedio.jsp
				  {
					  /*se sustituye la linea y a la funcion se le envian parametro/*ByYolo-Guz*/
// 					  window.parent.customAlert('Se guard� correctamente la informaci�n', '',regresarControl );
					  window.parent.customAlert('Se guard� correctamente la informaci�n');
					  regresarControl(id,tipoEmbarcacion);
				  }
			  }
			  else if(idEmbarcacion==0 && id==0)
			  {
				  window.parent.alertDinamico("Favor de revisar la informaci�n capturada");
			  }
			  else  //Actualizacion del elemento - solo desde el ingresarMenuIntermedio.jsp 
			  {   
				  //Se valida si se ha ingresado una imagen nueva o a actualizar
				  if (document.frmImagenElemento.archivo.value != ''){
					  //Para guardar la imagen
					  enviaImagenDeElemento(id);  
				  } 
				  /*se sustituye la linea y a la funcion se le envian parametro/*ByYolo-Guz*/
// 				  window.parent.customAlert('La informaci�n se actualiz� correctamente', '',regresarControl );
				  window.parent.customAlert('La informaci�n se actualiz� correctamente', '',regresarControl );
				  regresarControl(id,tipoEmbarcacion);
			  }
			}
		});
	}
	
	/**
	* Funcion que permite controlar y evitar que el alert desaparecas y se cierre la ventana
	* solo si viene desde asentarRegCadenaCustodia.sjp
	*/
	function regresarControlCadenaCustodia(){
		window.parent.cargaObjetoCerrarVentana();
	}
	/**
	* Funcion que permite controlar y evitar que el alert desaparecas y se cierre la ventana
	* solo si viene desde ingresarMenuIntermedio.jsp
	*/	
	/*se agregan los parametros/*ByYolo-Guz*/
	function regresarControl(id,tipoEmbarcacion){
		window.parent.cargaEmbarcacion(id,tipoEmbarcacion);
	}
	
	function validaCamposObligatorios(){
		var tipoEmbarcacion = $("#cbxTipoEmbarcacion option:selected").val();		
		var marcaEmbarcacion = $("#cbxMarcaEmbarcacion option:selected").val();
		var submarcaEmbarcacion = $("#cbxSubMarcaEmbarcacion option:selected").val();
		var colorEmbarcacion = $("#cbxColorEmbarcacion option:selected").val();
		var paisOrigenEmbarcacion = $("#cbxPaisOrigenEmbarcacion option:selected").val();
		var condicionEmbarcacion = $("#cbxCondicionEmbarcacion option:selected").val();
		var mensaje = "";
		//Primera validacion por cada campo obligatorio		
		if(parseInt(tipoEmbarcacion) == -1){
			mensaje += "<br />- Tipo de la embarcaci�n";			
		}
		if(parseInt(marcaEmbarcacion) == -1){
			mensaje += "<br />- Marca de la embarcaci�n";			
		}
		if(parseInt(submarcaEmbarcacion) == -1){
			mensaje += "<br />- Submarca de la embarcaci�n";			
		}
		if(parseInt(colorEmbarcacion) == -1){
			mensaje += "<br />- Color de la embarcaci�n";			
		}
		if(parseInt(paisOrigenEmbarcacion) == -1){
			mensaje += "<br />- Pa�s de origen de la embarcaci�n";			
		}		
		if(parseInt(condicionEmbarcacion) == -1){
			mensaje += "<br />- Condici�n de la embarcaci�n";			
		}
		//Comienza segunda validacion para validacion de consistencia de expresiones regulares
		if(mensaje != ""){
			//mensaje += "\n\nEs necesario...."; FUTURAS VALIDACIONES
			if(parseInt( ocultaAnularObjetoCadCus ) ==1)
			{// alert especial cuando agregamos el objeto como evidencia en la cadena de custodia
				window.parent.alertDinamicoEvCadCus("Favor de revisar la informaci�n capturada");
			}
			else
			{
				window.parent.alertDinamico("<p align='left'>Favor de revisar los siguientes campos obligatorios: <br />"+mensaje+"</p>");
			}
		}else{			
			obtenerValoresEmbarcacion();
		}
	}
	
	/*Funcion que permite guardar una imagen
	* Se define en la forma:
	*	-id del elemento para relacionarlo a la imagen.
	*   -tipo de elemento para que, en el action, se difernecie sobre el tipo de elemento 
	*/
	function enviaImagenDeElemento(idElemento){
			document.frmImagenElemento.elementoID.value = idElemento;
			document.frmImagenElemento.tipoElementoId.value = '<%= TipoElemento.OBJETO.getValorId() %>';
	    	document.frmImagenElemento.submit();
	}
	
	/*
	*Funcion que manda a eliminar logicamente el objeto en la BD
	*/
	function anularObjeto(){
		var paramEmbarcacion="idObjeto="+idEmbarcacion;
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/anularObjetoPorId.do',
			data: paramEmbarcacion,
			dataType: 'xml',
			success: function(xml){
				//procederemos a tratar de eliminar la evidencia
				if(parseInt($(xml).find('bandera').text())==1)
				{
					//se anulo exitosamente el objeto , actualizamos el grid de menu intermedio y cerramos la ventana
					window.parent.cargaEmbarcacion(idEmbarcacion,"");
					window.parent.cerrarVentanaEmbarcacion();
				}
				if(cadenaCustodia=='null'){
					//alert("cadCus::"+cadenaCustodia);
					window.parent.alertDinamico($(xml).find('mensajeOp').text());
				}
			}
		});

	}
	
	/*
	*Funcion para anular el objeto
	*/
	function solicitarAnlrObjeto(){
		//revisamos si es una consulta
		if(idEmbarcacion!=null && idEmbarcacion!=0)
		{
			//procederemos a tratar de eliminar la evidencia
			customConfirm ("�Est� seguro que desea anular el objeto?", "", validarObjEvdncNoEslbns);
		}
	}
	
	/*
	*Funcion que validara si el objeto es evidencia y NO tiene eslabones, de ser asi
	*se debe confirmar que se desea eliminar dado que el objeto ya esta en una cadena de custdia
	*/
	function validarObjEvdncNoEslbns()
	{
		var paramEmbarcacion="idObjeto="+idEmbarcacion;
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/validarObjPorIdEvdncNoEslbns.do',
			data: paramEmbarcacion,
			dataType: 'xml',
			success: function(xml){
				//procederemos a tratar de eliminar la evidencia
				if(parseInt($(xml).find('bandera').text())==1)
				{
					//debemos mostrar un confirm
					customConfirm ("El objeto es ya una evidencia en alguna cadena de custodia <br/> �Est� seguro que desea anular el objeto?", "", anularObjeto);
				}
				else if(parseInt($(xml).find('bandera').text())==2)
				{
					//se puede eliminar el objeto sin problemas
					anularObjeto();
				}
				else
				{
					window.parent.alertDinamico($(xml).find('mensajeOp').text());
				}
			}
		});
	}
	
	window.onload = function(){
		var selects = document.getElementsByTagName("textarea");
		for (var i = 0; i < selects.length; i++) { 
			if(selects[i].getAttribute("maxlength") > 0){
				selects[i].onkeydown = function(){
	                            if (this.value.length > this.getAttribute("maxlength")) 
	                                this.value = this.value.substring(0, this.getAttribute("maxlength"));
	                        }
	                        selects[i].onblur = function(){
	                            if (this.value.length > this.getAttribute("maxlength")) 
	                                this.value = this.value.substring(0, this.getAttribute("maxlength"));
	                        }
			}
		}
	}
	</script>
</head>
 
<body>
        	<table width="560px" height="448" border="0" cellspacing="0" cellpadding="0">
              <tr><td>&nbsp;</td></tr>        		
              <tr height="6.25%">
                <td width="28%" height="21" class="txt_gral_victima" id="anularInv" align="right"></td>
              <td width="36%">&nbsp;</td>
                <td width="36%" align="right">
                	<input type="button" value="Anular objeto" class="btn_Generico"id="anularElemento" onclick="solicitarAnlrObjeto()"/>&nbsp;&nbsp;
                	<input type="button" id="btnGuardarEmbarcacion" onclick="validaCamposObligatorios();" value="Guardar" class="btn_Generico" />
                </td>
              </tr>
              <tr><td>&nbsp;</td></tr>
              <tr height="6.25%">
                <td width="28%" height="21" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
                <td width="36%" align="center">Descripci&oacute;n:</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">*Tipo:</td>
                <td width="36%"><select id="cbxTipoEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
                <td width="36%" rowspan="7" align="center"><textarea cols="25" rows="9" id="txtBoxDescEmbarcacion" maxlength="200"></textarea></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">*Marca:</td>
                <td width="36%"><select id="cbxMarcaEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">*Submarca:</td>
                <td width="36%"><select id="cbxSubMarcaEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">*Color:</td>
                <td width="36%"><select id="cbxColorEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">*Pa&iacute;s de Origen:</td>
                <td width="36%"><select id="cbxPaisOrigenEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">Nombre de la Embarcaci&oacute;n:</td>
                <td width="36%"><input type="text" id="txtNombreEmbarcacion" maxlength="30" style="width:175px"/></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">Matr�cula:</td>
                <td width="36%"><input type="text" id="txtMatriculaEmbarcacion" maxlength="15" style="width:175px"/></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">No. de Motor:</td>
                <td width="36%"><input type="text" id="txtNoMotorEmbarcacion" maxlength="20" style="width:175px"/></td>
                <td width="36%" align="center">Fotograf&iacute;a:</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" height="24" align="right">No. de Serie:</td>
                <td width="36%"><input type="text" id="txtNoSerieEmbarcacion" maxlength="30" style="width:175px"/></td>
                <td rowspan="6" align="center"><img id="imgConFoto" src="<%=request.getContextPath()%>/resources/images/Foto.JPG" alt="foto del objeto" width="185" height="165" /></td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" height="25" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" height="36" align="right">*Condici&oacute;n:</td>
                <td width="36%"><select id="cbxCondicionEmbarcacion" style="width:180px">
                  <option value="-1">-Seleccione-</option>
                </select></td>
              </tr>
              <tr id="trRelacionHecho" height="12.5%">
              	<td align="right">Relaci&oacute;n del hecho: </td>
              	<td >
              		<select name="cbxRelacionHecho" id="cbxRelacionHecho" style="width:180px">
              			<option value="-1">-Seleccione-</option>
              		</select>
              	</td>
              </tr>
              <tr height="6.25%">
                <td width="28%" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
                <td width="36%">&nbsp;</td>
              </tr>
              
            </table>
   		<table width="550px" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="right">
			<form id="frmImagenElemento" name="frmImagenElemento" action="<%= request.getContextPath() %>/ingresarImagenDelElementoEmbarcacion.do" method="post" enctype="multipart/form-data" align="left">
			         		<input type="hidden" name="elementoID"/>
			                <input type="file" name="archivo" id="uploadArchivo">
			                <input type="hidden" name="tipoElementoId"/>
        	</form>
		</td>
	</tr>			
	</table>
</body>
</html>