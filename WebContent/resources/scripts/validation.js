$().ready(function(){
  $("#loginForm").validate({
    rules:{
      doc:{
        required: true
      },
      senha:{
        required: true
      },
      email:{
    	  required: true,
    	  email: true
      }
    },
    messages:{
      doc: "Informe o documento de identifica&ccedil;&atilde;o",
      senha: "Informe sua senha",
      email: {
    	  required: "Informe seu e-mail",
    	  email: "Informe um e-mail v&aacute;lido"
      }
    }
  });
  
  $("#registerForm").validate({
	    rules:{
	      nome:{
	        required: true
	      },
	      matricula:{
		    required: true
		  },
	      senha1:{
	        required: true
	      },
	      senha2:{
		    required: true,
		    equalTo: "#senha1"
		  },
	      email:{
	    	  required: true,
	    	  email: true
	      },
	      dtNascimento:{
		        required: true
		  },
		  naturalidade:{
			  required: true
		  },
		  nacionalidade:{
			  required: true
		  },
		  documento:{
			  required: true
		  },
		  emissor:{
			  required: true
		  },
		  endereco:{
			  required: true
		  },
		  cep:{
			  required: true
		  },
		  bairro:{
			  required: true
		  }
	    },
	    messages:{
	      nome: "Informe seu nome",
	      senha1: "Informe sua senha de acesso",
	      matricula: "Informe sua matr&iacute;cula", 
	      email: {
	    	  required: "Informe seu e-mail",
	    	  email: "Informe um e-mail v&aacute;lido"
	      },
	      senha2: {
	    	  required: "Confirme sua senha de acesso",
	    	  equalTo: "As senhas n&atilde;o conferem"
	      },
	      dtNascimento: "Informe sua data de nascimento",
		  naturalidade: "Informe sua naturalidade",
		  nacionalidade: "Informe sua nacionalidade",
		  documento: "Informe seu documento de identidade",
		  emissor: "Informe o &oacute;rg&atilde;o emissor do documento",
		  endereco: "Informe seu endere&ccedil;o",
		  cep: "Informe o CEP",
		  bairro: "Informe o bairro"
	    }
  });
  
  $("#passwordForm").validate({
	    rules:{
	      senhaAtual:{
	        required: true
	      },
	      novaSenha1:{
	        required: true
	      },
	      novaSenha2:{
	    	required: true,
	    	equalTo: "#novaSenha1"
	      }
	    },
	    messages:{
		    senhaAtual: "Informe sua senha atual",
		    novaSenha1: "Informe sua nova senha",
		    novaSenha2: {
		    	  required: "Confirme sua nova senha",
		    	  equalTo: "As senhas n&atilde;o conferem"
		    },
	    }
  });
  
  $("#formCadastro").validate({
	    rules:{
	      nome:{
	        required: true
	      },
	      matricula:{
		    required: true
		  },
	      senha1:{
	        required: true
	      },
	      senha2:{
		    required: true,
		    equalTo: "#senha1"
		  },
	      email:{
	    	  required: true,
	    	  email: true
	      },
	      dtNascimento:{
		        required: true
		  },
		  naturalidade:{
			  required: true
		  },
		  nacionalidade:{
			  required: true
		  },
		  documento:{
			  required: true
		  },
		  emissor:{
			  required: true
		  },
		  endereco:{
			  required: true
		  },
		  cep:{
			  required: true
		  },
		  bairro:{
			  required: true
		  }
	    },
	    messages:{
	      nome: "Informe seu nome",
	      senha1: "Informe sua senha de acesso",
	      matricula: "Informe sua matr&iacute;cula", 
	      email: {
	    	  required: "Informe seu e-mail",
	    	  email: "Informe um e-mail v&aacute;lido"
	      },
	      senha2: {
	    	  required: "Confirme sua senha de acesso",
	    	  equalTo: "As senhas n&atilde;o conferem"
	      },
	      dtNascimento: "Informe sua data de nascimento",
		  naturalidade: "Informe sua naturalidade",
		  nacionalidade: "Informe sua nacionalidade",
		  documento: "Informe seu documento de identidade",
		  emissor: "Informe o &oacute;rg&atilde;o emissor do documento",
		  endereco: "Informe seu endere&ccedil;o",
		  cep: "Informe o CEP",
		  bairro: "Informe o bairro"
	    }
  });
  
  $("#registroVacina").validate({
	    rules:{
	    	dataVacina:{
	    		required: true
	    	},
	    	codPessoa:{
	    		required: true
	    	}
	    },
	    messages:{
	    	dataVacina: "Informe a data da vacina",
	    	codPessoa: "Informe a pessoa do registro"
	    }
  });
  
  $("#searchPessoa").validate({
	    rules:{
	    	idPessoa:{
	    		required: true
	    	}
	    },
	    messages:{
	    	idPessoa: "Informe o documento de identidade"
	    }
  });
  
  $("#formCadastro").validate({
	    rules:{
	      nome:{
	        required: true
	      },
	      razao:{
		    required: true
		  },
		  cnes:{
	        required: true
	      },
	      cnpj:{
		    required: true
		  },
		  telefone:{
	    	  required: true
	      },
		  endereco:{
			  required: true
		  },
		  cep:{
			  required: true
		  },
		  bairro:{
			  required: true
		  }
	    },
	    messages:{
	      nome: "Informe o nome fantasia",
	      razao: "Informe a raz&atilde;o social",
	      cnes: "Informe o CNES",
	      cnpj: "Informe o CNPJ",
	      telefone: "Informe o telefone",
		  endereco: "Informe seu endere&ccedil;o",
		  cep: "Informe o CEP",
		  bairro: "Informe o bairro"
	    }
  });
});