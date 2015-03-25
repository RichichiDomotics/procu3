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
<title>Ingresar Sustancia</title>
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
	
	var rolActivo = '<%=rolActivo%>';
	var entidadFedYuc = '<%=EntidadFederativa.YUCATAN.getValorId()%>';
	var idSustancia="";
	var tipoObjeto="";
	var numeroExpediente="";
	var cadenaCustodia="";
	var fechaLevCadCus="";
	var origenEvdCadCus="";
	var deshabilitarCampos = window.parent.deshabilitarCamposPM;
	var ocultaAnularObjetoCadCus=null;
	
	var contextoPagina = "${pageContext.request.contextPath}";
	
	var esModoConsulta = '<%= request.getParameter("esModoConsulta")%>';

	
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
			
			idSustancia='<%= request.getParameter("idSustancia")%>';
			cadenaCustodia='<%= request.getParameter("cadenaCustodia")%>';
			fechaLevCadCus='<%= request.getParameter("fechaLevCadCus")%>';
			origenEvdCadCus='<%= request.getParameter("origenEvdCadCus")%>';
			
			if (idSustancia != null && idSustancia != 0)
				$("#imgConFoto").attr("src",'<%=request.getContextPath()%>/obtenImagenDeElemento.do?elementoID=<%= request.getParameter("idSustancia")%>');
			else{
				$("#imgConFoto").attr("src","<%=request.getContextPath()%>/resources/images/Foto.JPG");
			}
			
			if(idSustancia=='null')
			{
				idSustancia=0;	
			}
			tipoObjeto='<%= request.getParameter("tipoObjeto")%>';
			
			cargaTiposSustancia();
			cargaTiposEmpaque();
			cargaUnidadesDeMedida();
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
				if(idSustancia!=null && idSustancia!=0){
					$(":enabled").attr('disabled','disabled');
					$('input[type="submit"]').hide();
					$('input[type="button"]').hide();	
				}
			}

			//revisamos si es una consulta
			if(idSustancia!=null && idSustancia!=0)
			{
				consultaSustancia();
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
	*Funcion que realiza la carga del combo de tipos de sustancia
	*/
	function cargaTiposSustancia() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarTiposSustancia.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catTiposSustancia').each(function(){
					$('#cbxTipoSustancia').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

	
	/*
	*Funcion que realiza la carga del combo de tipos de empaque para la sustancia
	*/
	function cargaTiposEmpaque() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarTiposEmpaque.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catEmpaque').each(function(){
					$('#cbxTipoEmpaqueSustancia').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}

	/*
	*Funcion que realiza la carga del combo de tipos de empaque para la sustancia
	*/
	function cargaUnidadesDeMedida() {
		  
		$.ajax({
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/consultarUnidadesMedida.do',
			data: '',
			dataType: 'xml',
			success: function(xml){
				$(xml).find('catUnidadMedida').each(function(){
					$('#cbxUnidadMedidaSustancia').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}


	/*
	*Funcion que realiza la carga de la condicion de la sustancia
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
					$('#cbxCondicionSustancia').append('<option value="' + $(this).find('clave').text() + '">' + $(this).find('valor').text() + '</option>');
				});
			}
		});
	}		

	/*
	*Funcion para mandar consultar el arma
	*/
	function consultaSustancia()
	{
		$.ajax({
    		type: 'POST',
    		url: '<%=request.getContextPath()%>/ConsultaObjetoPorId.do',
    		data: 'idObjeto='+idSustancia,
    		dataType: 'xml',
    		async: false,
    		success: function(xml){
    			if(parseInt($(xml).find('code').text())==0)
	    		{
    				//seteamos la informacion de la Sustancia
    				$(xml).find('SustanciaDTO').each(function(){
    						seteaDatosSustancia($(this));
		    	      });
	    		}
    		}	
    	});
	}
	
	function seteaDatosSustancia(xml)
	{
		$('#cbxTipoSustancia').find("option[value='"+$(xml).find('tipoSustancia').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxTipoEmpaqueSustancia').find("option[value='"+$(xml).find('empaque').find('idCampo').text()+"']").attr("selected","selected");
		$("#txtCantidadSustancia").val($(xml).find('cantidad').text());
		$('#cbxUnidadMedidaSustancia').find("option[value='"+$(xml).find('unidadMedida').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxCondicionSustancia').find("option[value='"+$(xml).find('valorByCondicionFisicaVal').find('idCampo').text()+"']").attr("selected","selected");
		$('#cbxRelacionHecho').find("option[value='"+$(xml).find('relacionHechoVal').find('idCampo').text()+"']").attr("selected","selected");
		if($(xml).find('almacen'))
			$(xml).find('almacen').remove();
		$("#txtBoxDescSustancia").val($(xml).find('descripcion').text());
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
	
//	COMIENZA FUNCIONES PARA EL GUARDADO DE LOS DATOS		
	function obtenerValoresSustancia(){		
		var paramSustancia = "idSustancia="+idSustancia;
		paramSustancia += '&glTipoSustanciaId=' + $("#cbxTipoSustancia option:selected").val();
		paramSustancia += '&glEmpaqueSustanciaId=' + $("#cbxTipoEmpaqueSustancia option:selected").val();
		paramSustancia += '&gsCantidadSustancia=' + $("#txtCantidadSustancia").val();
		paramSustancia += '&glUnidadMedidaId=' + $("#cbxUnidadMedidaSustancia option:selected").val();
		paramSustancia += '&glCondicionFisicaSustanciaId=' + $("#cbxCondicionSustancia option:selected").val();
		paramSustancia += '&gcDescripcionSustancia=' + $("#txtBoxDescSustancia").val();
		paramSustancia += '&relacionHechoId=' + $("#cbxRelacionHecho option:selected").val();
		
		if(cadenaCustodia!='null')
		{
			paramSustancia += '&cadenaCustodia=' + cadenaCustodia;
			paramSustancia += '&origenEvdCadCus=' + origenEvdCadCus;
			paramSustancia += '&fechaLevCadCus=' + fechaLevCadCus;
		}
		
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/ingresarSustancia.do?numeroExpediente='+numeroExpediente +'',
			data: paramSustancia,
			dataType: 'xml',
			success: function(xml){
				
				var tipoSustancia = $("#cbxTipoSustancia option:selected").text();
				  var id = $(xml).find('SustanciaForm').find('glTipoSustanciaId').text();
				
				  //Se ha agregado nuevo elemento
				  if(idSustancia==0 && id>0)
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
// 						  window.parent.customAlert('Se guard� correctamente la informaci�n', '',regresarControl );
						  window.parent.customAlert('Se guard� correctamente la informaci�n');
						  regresarControl(id,tipoSustancia);
					  }
				  }
				  else if(idSustancia==0 && id==0)
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
// 					  window.parent.customAlert('La informaci�n se actualiz� correctamente', '',regresarControl );
					  window.parent.customAlert('La informaci�n se actualiz� correctamente');					  
					  regresarControl(id,tipoSustancia);
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
	function regresarControl(id,tipoSustancia){
		 window.parent.cargaSustancia(id,tipoSustancia);
	}

	function validaCamposObligatorios(){
		var tipoSustancia = $("#cbxTipoSustancia option:selected").val();
		var tipoEmpaqueSustancia = $("#cbxTipoEmpaqueSustancia option:selected").val();
		var unidadMedidaSustancia = $("#cbxUnidadMedidaSustancia option:selected").val();
		var condicionSustancia = $("#cbxCondicionSustancia option:selected").val();
		var mensaje = "";
		//Primera validacion por cada campo obligatorio		
		if(parseInt(tipoSustancia) == -1){
			mensaje += "<br />- Tipo de la sustancia";			
		}
		if(parseInt(tipoEmpaqueSustancia) == -1){
			mensaje += "<br />- Tipo de empaque de la sustancia";			
		}
		if(parseInt(unidadMedidaSustancia) == -1){
			mensaje += "<br />- Unidad de medida de la sustancia";			
		}
		if(parseInt(condicionSustancia) == -1){
			mensaje += "<br />- Condici�n de la sustancia";			
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
			obtenerValoresSustancia();
		}
	}
	
	/*
	*Funcion que manda a eliminar logicamente el objeto en la BD
	*/
	function anularObjeto(){
		var paramSustancia="idObjeto="+idSustancia;
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/anularObjetoPorId.do',
			data: paramSustancia,
			dataType: 'xml',
			success: function(xml){
				//procederemos a tratar de eliminar la evidencia
				if(parseInt($(xml).find('bandera').text())==1)
				{
					//se anulo exitosamente el objeto , actualizamos el grid de menu intermedio y cerramos la ventana
					window.parent.cargaSustancia(idSustancia,"");
					window.parent.cerrarVentanaSustancia();
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
		if(idSustancia!=null && idSustancia!=0)
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
		var paramSustancia="idObjeto="+idSustancia;
		$.ajax({		
			async: false,
			type: 'POST',
			url: '<%= request.getContextPath()%>/validarObjPorIdEvdncNoEslbns.do',
			data: paramSustancia,
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
				 <table width="750px"  height="220px" border="0" align="center" cellpadding="0" cellspacing="0">
				 	 <tr><td>&nbsp;</td></tr>
				     <tr height="12.5%">
				         <td width="20%" id="anularInv"></td>
				         <td width="28%"></td>
				         <td width="26%">&nbsp;</td>
				         <td width="26%" align="right">
				         	<input type="button" value="Anular objeto" class="btn_Generico"id="anularElemento" onclick="solicitarAnlrObjeto()"/>&nbsp;&nbsp;
				         	<input type="button" id="btnGuardarSustancia" value="Guardar" class="btn_Generico" onclick="validaCamposObligatorios();" />
				         </td>
				     </tr>
				 	 <tr><td>&nbsp;</td></tr>				   
                     <tr height="12.5%">
				         <td width="20%">&nbsp;</td>
				         <td width="28%">&nbsp;</td>
				         <td width="26%" align="center">Descripci&oacute;n:</td>
				         <td width="26%" align="center">Fotograf�a:</td>
				     </tr >
				     <tr height="12.5%">
				         <td width="20%" align="right">*Tipo:</td>
				         <td width="28%"><select id="cbxTipoSustancia" style="width:180px">
				          <option value="-1">-Seleccione-</option>
				        </select></td>
				        <td width="26%" rowspan="6" align="center" valign="top">
				            <textarea cols="29" rows="9" id="txtBoxDescSustancia" maxlength="200"></textarea>
				        </td>
				        <td width="26%" rowspan="6" align="center" valign="middle"><img id="imgConFoto" src="<%=request.getContextPath()%>/resources/images/Foto.JPG" alt="foto del objeto" width="185" height="185" /></td>
				    </tr>
				    <tr height="12.5%">
				        <td width="20%" align="right">*Tipo de empaque:</td>
				        <td width="28%"><select id="cbxTipoEmpaqueSustancia" style="width:180px">
				          <option value="-1">-Seleccione-</option>
			            </select></td>
				    </tr>
				    <tr height="12.5%">
				        <td width="20%" align="right">Cantidad:</td>
				        <td width="28%"><input type="text" id="txtCantidadSustancia" maxlength="5" style="width:175px"/></td>
				    </tr>
				    <tr height="12.5%">
				        <td width="20%" align="right">*Unidad de Medida:</td>
				        <td width="28%"><select id="cbxUnidadMedidaSustancia" style="width:180px">
				          <option value="-1">-Seleccione-</option>
			            </select></td>
				    </tr>
				    <tr height="12.5%">
				        <td width="20%" align="right">&nbsp;</td>
				        <td width="28%">&nbsp;</td>
				    </tr>
				    <tr height="12.5%">
				        <td width="20%" align="right">*Condici&oacute;n:</td>
				        <td width="28%"><select id="cbxCondicionSustancia" style="width:180px">
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
				    <tr height="12.5%">
				        <td width="20%" align="right">&nbsp;</td>
				        <td width="28%">&nbsp;</td>
				        <td width="26%">&nbsp;</td>
				        <td width="26%">&nbsp;</td>
				    </tr>
				</table>
	<table width="750px" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">
				<form id="frmImagenElemento" name="frmImagenElemento" action="<%= request.getContextPath() %>/ingresarImagenDelElementoSustancia.do" method="post" enctype="multipart/form-data" align="left">
				         		<input type="hidden" name="elementoID"/>
				                <input type="file" name="archivo" id="uploadArchivo">
				                <input type="hidden" name="tipoElementoId"/>
	        	</form>
			</td>
		</tr>
	</table>
  </body>
</html>