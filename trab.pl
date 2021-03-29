% Grupo:
%       Carlos Gabriel
%       Isaque Almeida
%       Luis Fernando

% MENU
ajuda() :- writeln("1: Para listar todos os candidatos digite: candidatosaptos"),
           writeln("2: Para saber as principais regioes dos candidatos digite: regioesprincipais"),
           writeln("3: Para listar os candidatos que estejam na mesma regiao digite: candidatosnamesmaregiao(REGIAO)"),
           writeln("4: Para saber qual e a faixa de idade dos candidatos digite: faixadeidadegeral"),
           writeln("5: Para listar a idade dos candidatos e saber se estao ou nao proximos a aposentaoria digite: faixadeidade"),
           writeln("6: Para verificar se o regime de contratacao de um candidato atende o seu digite: regimedecontratacaode(REGIME DESEJADO, NOME DO CANDIDATO)"),
           writeln("7: Para listar todos os candidatos que atendem ao regime de contrato desejado digite: regimedecontratacao(REGIME DESEJADO)"),
           writeln("8: Para listar candidatos com o salario dentro do desejado, digite: candidatosate(SALARIO PRETENDIDO)"),
           writeln("9: Para saber se o candidato tem o salario compativel, digite: salarioecompativel(NOME DO CANDIDATO, SALARIO QUE DESEJA PAGAR)"),
           writeln("10: Para listar os melhores candidatos, digite: melhorescandidatos(LINGUAGEM)"),
           writeln("11: Para listar os melhores candidatos que moram em uma cidade especifica, digite: melhoresporcidade(LINGUAGEM, CIDADE)").


% candidato(nome, idade, linguagem, nivel, salario, regime, cidade, proximo a se aposentar, Id do Nivel)
% Nivel ID: Junior = 1, Pleno = 2, Senior = 3.
% nivel : junior, pleno, senior
% regime: PJ(Pessoa Juridica), CLT

% BD

candidato(joao, 45, ruby, senior, 6000, clt, guaruja, nao, 3).
candidato(paulo, 30, cpp, pleno, 3600, clt, guaruja, nao, 2).
candidato(luis, 56, swift, senior, 9000, clt, bertioga, sim, 3).
candidato(pedro, 23, go, junior, 2500, clt, santos, nao, 1).
candidato(guilherme, 20, go, junior, 2700, pj, santos, nao, 1).
candidato(felipe, 29, ruby, pleno, 3900, clt, guaruja, nao, 2)
candidato(daniela, 33, swift, pleno, 4000, pj, santos, nao, 2).
candidato(patricia, 48, cpp, senior, 7000, clt, santos, nao, 3).
candidato(carol, 40, cpp, senior, 5000, pj, santos, nao, 3).
candidato(gabriela, 33, ruby, pleno, 4000, clt, bertioga, nao, 2).


regiao(joao, guaruja).
regiao(paulo, guaruja).
regiao(luis, bertioga).
regiao(pedro, santos).
regiao(carol, santos).
regiao(gabriela, bertioga).
regiao(guilherme, santos).
regiao(felipe, guaruja).
regiao(daniela, santos).
regiao(patricia, santos).

idade(joao, 45).
idade(paulo, 30).
idade(luis, 56).
idade(pedro, 23).
idade(carol, 40).
idade(gabriela, 33).
idade(guilherme, 20)
idade(felipe, 29)
idade(daniela, 33)
idade(patricia, 48)


salario(joao, 6000).
salario(paulo, 3600).
salario(luis, 9000).
salario(pedro, 2500).
salario(carol, 5000).
salario(gabriela, 4000).
salario(guilherme, 2700).
salario(felipe, 3900).
salario(daniela, 4000).
salario(patricia, 7000).

regime(joao, clt).
regime(paulo, clt).
regime(luis, clt).
regime(pedro, clt).
regime(carol, pj).
regime(gabriela, clt).
regime(guilherme, pj).
regime(felipe, clt).
regime(daniela, pj).
regime(patricia, clt).

% Estão próximos da aposentadoria?
proximoaaposentadoria(A) :- candidato(A,_,_,_,_,_,_,X,_), X = 'sim' -> format("O candidato ~s esta proximo de se aposentar", A) ; format("O candidato ~s NAO esta proximo de se aposentar", A).

% A faixa de salário oferecida é compatível com as pretendidas? (A = nome, B = faixa de salario)
salarioecompativel(A, B) :- salario(A, X), X =< B + B/10 -> writeln("O salario E compativel") ; writeln("O salario NAO e compativel").

% Lista candidatos com o salario até o estipulado
candidatosate(A) :- format("| ~s~t~20|| ~s~t~35|| ~s~t~50|| ~s~t~56| | ~s~t~65| | ~s~t~75|| ~s~t~90||~n", ["NOME", "LINGUAGEM", "SALARIO", "IDADE", "NIVEL", "REGIME", "CIDADE"]),
                    candidato(Nome, Idade, Linguagem, Nivel, S, Regime, Cidade,_,_), S =< A,
                    format("| ~s~t~20|| ~s~t~35|| ~d~t~50|| ~d~t~57| | ~s~t~66| | ~s~t~76|| ~s~t~91||~n", [Nome, Linguagem, S, Idade, Nivel, Regime, Cidade]), fail;true.

% O regime de contratação é compatível com o regime de contratação pretendido pelos candidatos?
% (A = regime da empresa, B = Nome do candidato)
regimedecontratacaode(A, B) :- regime(B, X), X == A -> true ; false.

print_regime([]).
print_regime([[Nome, Linguagem, Idade, Nivel, Regime, Cidade]|Y]) :- format("| ~s~t~25|| ~s~t~44|| ~d~t~53|| ~s~t~64| | ~s~t~73| | ~s~t~95||~n", [Nome, Linguagem, Idade, Nivel, Regime, Cidade]), print_regime(Y).
regimedecontratacao(A) :- format("| ~s~t~25|| ~s~t~44|| ~s~t~53|| ~s~t~64| | ~s~t~73| | ~s~t~95||~n", ["NOME", "LINGUAGEM", "IDADE", "NIVEL", "REGIME", "CIDADE"]), findall([Nome, Linguagem, Idade, Nivel, A, Cidade], candidato(Nome, Idade, Linguagem, Nivel, _, A, Cidade, _, _), RDC), print_regime(RDC).

% Quais as principais regiões de moradia dos candidatos?
print_regioes([]).
print_regioes([X|Y]) :- format(" ~s |", X), print_regioes(Y).
regioesprincipais() :- write("As principais regioes de moradia dos candidatos sao:"), setof(R, A^regiao(A, R), Regioes), print_regioes(Regioes), fail;true.

% Quantos e quais candidatos estão na mesma região da empresa recrutadora?
% CMR = Candidatos na Mesma Regiao
print_all_list([]).
print_all_list([[Nome, Linguagem, Idade, Nivel, Cidade]|Y]) :- format("| ~s~t~25|| ~s~t~44|| ~d~t~53|| ~s~t~64| | ~s~t~90||~n", [Nome, Linguagem, Idade, Nivel, Cidade]), print_all_list(Y).
candidatosnamesmaregiao(Cidade) :- format("| ~s~t~25|| ~s~t~44|| ~s~t~53|| ~s~t~64| | ~s~t~90||~n", ["NOME", "LINGUAGEM", "IDADE", "NIVEL", "CIDADE"]), findall([Nome, Linguagem, Idade, Nivel, Cidade], candidato(Nome, Idade, Linguagem, Nivel, _, _, Cidade, _, _), CMR), print_all_list(CMR), fail;true.

% Faixa de idade geral dos candidatos
% Ig = Idade Geral
faixadeidadegeral() :- findall(I, idade(_,I), Ig), min_member(MenorIdade, Ig), max_member(MaiorIdade, Ig), format("A faixa de idade dos candidatos esta entre ~d e ~d anos.", [MenorIdade, MaiorIdade]).

% Faixa de idade para cada candidato e se ele esta ou nao proximo a se aposentar
% PA = Proximo a Aposentadoria
print_faixadeidade([]).
print_faixadeidade([[Nome, Idade, PA]|Y]) :- format("| ~s~t~25|| ~d~t~44|| ~s~t~68||~n", [Nome, Idade, PA]), print_faixadeidade(Y).
faixadeidade() :-  format("| ~s~t~25|| ~s~t~44|| ~s~t~68||~n", ["NOME", "IDADE", "PROX. A APOSENTADORIA"]), findall([Nome, Idade, PA], candidato(Nome, Idade, _, _, _, _, _, PA, _), FIL), print_faixadeidade(FIL).

% Lista os candidatos aptos a participar do processo seletivo
candidatosaptos() :- aggregate_all(count, candidato(_,_,_,_,_,_,_,_,_), Total), format("Total de ~d candidatos aptos!~n", Total), format("| ~s~t~25|| ~s~t~44|| ~s~t~53|| ~s~t~64| | ~s~t~90||~n", ["NOME", "LINGUAGEM", "IDADE", "NIVEL", "CIDADE"]), candidato(Nome, Idade, Linguagem, Nivel, _, _, Cidade, _, _), format("| ~s~t~25|| ~s~t~44|| ~d~t~53|| ~s~t~64| | ~s~t~90||~n", [Nome, Linguagem, Idade, Nivel, Cidade]), fail;true.

% Lista os melhores candidatos para a vaga com base na linguagem
% MC = Melhores Candidatos
% MCO = Melhores Candidatos Ordenados
print_melhores([]).
print_melhores([[Nome, Nivel, Idade, Salario, Cidade, Regime, _]|Y]) :- format("| ~s~t~20|| ~s~t~30|| ~d~t~38|| ~d~t~52|| ~s~t~74|| ~s~t~83||~n", [Nome, Nivel, Idade, Salario, Cidade, Regime]), print_melhores(Y).
melhorescandidatos(Linguagem) :- format("| ~s~t~20|| ~s~t~30|| ~s~t~38|| ~s~t~52|| ~s~t~74|| ~s~t~83||~n", ["NOME", "NIVEL", "IDADE", "SALARIO", "CIDADE", "REGIME"]), findall([Nome, Nivel, Idade, Salario, Cidade, Regime, NivelId], candidato(Nome, Idade, Linguagem, Nivel, Salario, Regime, Cidade, _, NivelId), MC), sort(2, >=, MC, MCO), print_melhores(MCO), fail;true.

% Lista os melhores candidatos para a vaga com base na linguagem e no local de moradia do candidato
% MC = Melhores Candidatos
% MCO = Melhores Candidatos Ordenados
print_melhoresporcidade([]).
print_melhoresporcidade([[Nome, Nivel, Idade, Salario, Cidade, Regime, _]|Y]) :- format("| ~s~t~20|| ~s~t~30|| ~d~t~38|| ~d~t~52|| ~s~t~74|| ~s~t~83||~n", [Nome, Nivel, Idade, Salario, Cidade, Regime]), print_melhores(Y).
melhoresporcidade(Linguagem, Cidade) :- format("| ~s~t~20|| ~s~t~30|| ~s~t~38|| ~s~t~52|| ~s~t~74|| ~s~t~83||~n", ["NOME", "NIVEL", "IDADE", "SALARIO", "CIDADE", "REGIME"]), findall([Nome, Nivel, Idade, Salario, Cidade, Regime, NivelId], candidato(Nome, Idade, Linguagem, Nivel, Salario, Regime, Cidade, _, NivelId), MC), sort(2, >=, MC, MCO), print_melhores(MCO), fail;true.
