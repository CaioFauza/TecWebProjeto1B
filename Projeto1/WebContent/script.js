$(document).ready(function(){
	$("#selectIdButtonDelete").click(function(){
		var boolCheckbox= document.getElementById("removeCheck").checked;
		if(boolCheckbox == false){
			alert("Erro! Por favor, marque a checkbox para continuar.");
		}
		
	});
	
	$("#loginButton").click(function(){
		var boolCheckbox= document.getElementById("removeCheck").checked;
		if(boolCheckbox == false){
			alert("Erro! Por favor, marque a checkbox para continuar.");
		}
		
	});
	
});