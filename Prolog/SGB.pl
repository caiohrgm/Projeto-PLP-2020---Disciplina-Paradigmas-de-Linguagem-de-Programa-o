:- initialization(main).
:- use_module(library(readutil)).

% bibliotecario(CPF,Nome).
bibliotecario("12345","Maria Madalena").

/*----------------------------------------------------------------------Menu Prévio & Opções-----------------------------------------------------------------*/
opcaoP(0) :- halt.
opcaoP(1) :- verificarBibliotecario(), menuOpcoesBibliotecario(); menuPrevio.
opcaoP(2) :- verificarVisitante(),writeln("Visitante encontrado!"),menuOpcoesVisitante(); writeln("Não cadastrado").
opcaoP(3) :- cadastrarVisitante(),menuPrevio().
opcaoP(_) :- writeln("Opção inválida. Tente novamente."),menuPrevio().

menuPrevio() :-
	writeln("\nBem-Vindo ao SGB."),
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair"), 
	writeln("1 - Sou Bibliotecário(a);"),
	writeln("2 - Sou Visitante;"),
	writeln("3 - Faça seu cadastro,visitante;"),
	read(P),
	opcaoP(P).
/*-----------------------------------------------------------------------Menu Bibliotecário e Opções----------------------------------------------------------*/
opcaoB(0) :- halt.	
opcaoB(1) :- buscarLivro(), menuOpcoesBibliotecario().
opcaoB(2) :- listarLivros(), menuOpcoesBibliotecario().				
opcaoB(3) :- listarLivrosAlugados(), menuOpcoesBibliotecario().
opcaoB(4) :- efetuarAluguel(), menuOpcoesBibliotecario().
opcaoB(5) :- efetuarDevolucao(), menuOpcoesBibliotecario().
opcaoB(6) :- listarSugestaoLivros(), menuOpcoesBibliotecario().
opcaoB(7) :- visualizarCapacidade(), menuOpcoesBibliotecario().
opcaoB(8) :- visualizarPorcentagemAlugados(), menuOpcoesBibliotecario().
opcaoB(9) :- listarLivrosDoados(), menuOpcoesBibliotecario().
opcaoB(10) :- cadastrarLivro(), menuOpcoesBibliotecario().
opcaoB(_) :- writeln("Opcao invalida, tente outra!"), menuOpcoesBibliotecario().

menuOpcoesBibliotecario() :- 
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair"),
	writeln("1 - Bucar livro;"), 
	writeln("2 - Listar todos os livros;"),
	writeln("3 - Listar livros alugados;"),
	writeln("4 - Efetuar Aluguel;"),
	writeln("5 - Efetuar Devolução;"),
	writeln("6 - Visualizar livros sugeridos;"),
	writeln("7 - Visualizar capacidade da biblioteca;"),
	writeln("8 - Visualizar porcentagem de livros alugados;"),
	writeln("9 - Visualizar doações;"),
	writeln("10 - Cadastrar novo livro no sistema;"),
	writeln("\nOpcao: "),
	read(B),
	opcaoB(B).
/*-----------------------------------------------------------------------Menu Visitante e Opções----------------------------------------------------------*/
opcaoV(0) :- halt.	
opcaoV(1) :- buscarLivro(), menuOpcoesVisitante().	
opcaoV(2) :- listarLivros(), menuOpcoesVisitante().					
opcaoV(3) :- listarLivrosAlugados(), menuOpcoesVisitante().		
opcaoV(4) :- enviarSugestaoLivro(), menuOpcoesVisitante().	
opcaoV(5) :- fazerDoacaoLivro(), menuOpcoesVisitante().	
opcaoV(6) :- fazerResenhaLivro(), menuOpcoesVisitante().
opcaoV(7) :- listarResenhasLivros(), menuOpcoesVisitante().	
opcaoV(_) :- writeln("Opcao invalida, tente outra!").

menuOpcoesVisitante() :- 
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair;"),
	writeln("1 - Bucar livro;"), 
	writeln("2 - Listar todos os livros;"),
	writeln("3 - Listar livros alugados;"),
	writeln("4 - Enviar sugestão de livro;"),
	writeln("5 - Fazer doação;"),
	writeln("6 - Fazer resenha de livro;"),
	writeln("7 - Visualizar resenhas de livros"),
	writeln("\nOpcao: "),
	read(V),
	opcaoV(V).
/*-------------------------------------------------------------------------------------Main-------------------------------------------------------------------*/
main :-
	menuPrevio().
/*-------------------------------------------------------------------------------------Funções Visitantes-------------------------------------------------------------------*/
cadastrarVisitante() :-
	writeln("Digite seu nome e CPF [Nome - CPF]: "),
	read(C),
    open('Dados/visitantes.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
	writeln("Visitante cadastrado com sucesso!"),
    close(File).

verificarVisitante() :-
	writeln("Digite seu CPF: "),
	read(C),
	lerArquivoVisitantes(Visitantes),
    encontrado(Visitantes,C).
/*--------------------------------------------------------------------Funções Bibliotecario(a)---------------------------------------------------------------*/
verificarBibliotecario() :-
	writeln("Digite seu CPF: "),
	read(C),
	call(bibliotecario(C,_)),
	writeln("\n"),
	writeln("Funcionário registrado."), writeln("Bem-vindo ao SGB"),
	menuOpcoesBibliotecario; writeln("Usuário não cadastrado."),
	menuPrevio.
/*--------------------------------------------------------------------Funções Livros-------------------------------------------------------------------------*/
cadastrarLivro() :- 
    writeln("Digite o índice, nome, gênero, ano e autor do livro, tudo entre aspas, separado por '-' e com ponto no final do último dado: "),
    writeln("Exemplo: ['1- nome livro-terror-... .'] "),
    read(C),
    open('Dados/livros.txt',append,File),
	formataGeral(S,C),
    writeln(File,S),
	writeln("Livro cadastrado com sucesso"),
    close(File).

buscarLivro() :- 
    writeln("Digite o nome do livro: "),
    read(C),
    lerArquivoLivros(Livros),
    encontraLivro(Livros,C), writeln("Livro encontrado") ; writeln("Livro não encontrado").

listarLivros() :- 
    lerArquivoLivros(L),
    writeln("Os livros da biblioteca são: "),
    writeln(L).

listarLivrosAlugados() :- halt.

listarSugestaoLivros() :- 
	writeln("os Livros sugeridos para aquisição são: "),
	lerArquivoSugestoes(Sugestoes),
	writeln(Sugestoes).

listarLivrosDoados() :- halt.

enviarSugestaoLivro() :- writeln("Escreva sua sugestão[Seu Nome - Nome do livro]:"),
	read(C),
    open('Dados/sugestoes.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
    close(File).

fazerDoacaoLivro() :- halt.

fazerResenhaLivro() :- 
	writeln("Digite seu nome, o nome do livro e sua resenha[Seu nome - Nome do Livro - Resenha]: "),
	read(C),
    open('Dados/resenhas.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
	writeln("Resenha cadastrada com sucesso."),
    close(File).

listarResenhasLivros(): - halt.
/*-------------------------------------------------------------------Funções Acervo Biblioteca----------------------------------------------------------------*/
efetuarAluguel() :- halt.

efetuarDevolucao() :- 
	writeln("Digite nome do livro a devolver:"),
	read(L),
    I = 0,
	lerArquivoAlugados(Alugados),
	encontraLivro(Livros,L,R),
	remove(R,Livros,NL),
	reescreve(NL,I), writeln("Livro devolvido com sucesso."); writeln("Este livro não está alugado.").

visualizarCapacidade() :- halt.

visualizarPorcentagemAlugados() :- halt.
/*-------------------------------------------------------------------Funções Auxiliares------------------------------------------------------------------*/
formataGeral(Out,L) :-
    format(string(Out),'~s',L).

remove(X,[X|C],C).
remove(X,[Y|C],[Y|D]) :- remove(X,C,D).

/* Função que reescreve cada elemento no arquivo alugados.txt, após a remoção do livro devolvido.*/
reescreve([],_).
reescreve([H|T],C) :- C == 0,
    open('Dados/alugados.txt',write,File),
    writeln(File,H),
    close(File), reescreve(T,C+1); 
    open('Dados/alugados.txt',append,File),
    writeln(File,H),
    close(File), reescreve(T,C+1). 
/*---------------Visitantes------------*/
lerArquivoVisitantes(Result) :-
    open('Dados/visitantes.txt',read,Str),
    read_stream_to_codes(Str,Visitantes),
    atom_string(Visitantes,Visitantes1),
    split_string(Visitantes1,"\n","",Result).

encontraVisitante([''],_).
encontraVisitante([X|T],Cpf) :- 
    split_string(X,"-"," ",X1),
    targetVisitante(X1,Cpf); encontraVisitante(T,Cpf).

targetVisitante([_|T],C) :- 
    nth0(0,T,E),
    E == C.
/*----------------Livros-------------*/
lerArquivoAlugados(Result) :-  
    open('Dados/alugados.txt',read,Str),
    read_stream_to_codes(Str,Livros),
    atom_string(Livros,Livros1),
    split_string(Livros1,"\n","",Result).

encontraAlugado([''],_,'').
encontraAlugado([X|T],Nome,R) :- 
    split_string(X,"-"," ",X1),
    targetLivro(X1,Nome),
	R = X;
	encontraLivro(T,Nome,R).

lerArquivoLivros(Result) :-  
    open('Dados/livros.txt',read,Str),
    read_stream_to_codes(Str,Livros),
    atom_string(Livros,Livros1),
    split_string(Livros1,"\n","",Result).

encontraLivro([''],_).
encontraLivro([X|T],Nome) :- 
    split_string(X,"-"," ",X1),
    targetLivro(X1,Nome); encontraLivro(T,Nome).

targetLivro([_|T],C) :- 
    nth0(0,T,E),
    E == C.

lerArquivoSugestoes(Result) :-
    open('Dados/sugestoes.txt',read,Str),
    read_stream_to_codes(Str,Sugestoes),
    atom_string(Sugestoes,Sugestoes1),
    split_string(Sugestoes1,"\n","",Result).
