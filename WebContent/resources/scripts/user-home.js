function habilitarCampos() {
	document.getElementById("cancelButton").style.display = "block";
	document.getElementById("saveButton").style.display = "block";
	document.getElementById("editButton").style.display = "none";
	document.getElementById("nome").disabled=false;
	document.getElementById("dtNascimento").disabled=false;
	document.getElementById("genero").disabled=false;
	document.getElementById("escolaridade").disabled=false;
	document.getElementById("endereco").disabled=false;
	document.getElementById("complemento").disabled=false;
	document.getElementById("bairro").disabled=false;
	document.getElementById("cep").disabled=false;
	document.getElementById("estado").disabled=false;
	document.getElementById("cidade").disabled=false;
	document.getElementById("telefone").disabled=false;
	document.getElementById("email").disabled=false;
}

function desabilitarCampos() {
	document.getElementById("cancelButton").style.display = "none";
	document.getElementById("saveButton").style.display = "none";
	document.getElementById("editButton").style.display = "block";
	document.getElementById("nome").disabled=true;
	document.getElementById("dtNascimento").disabled=true;
	document.getElementById("genero").disabled=true;
	document.getElementById("escolaridade").disabled=true;
	document.getElementById("endereco").disabled=true;
	document.getElementById("complemento").disabled=true;
	document.getElementById("bairro").disabled=true;
	document.getElementById("cep").disabled=true;
	document.getElementById("estado").disabled=true;
	document.getElementById("cidade").disabled=true;
	document.getElementById("telefone").disabled=true;
	document.getElementById("email").disabled=true;
}
