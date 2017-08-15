module transportadora

one sig CentralTransportadora {

	--Criando uma central de transportadoras, que possuirá todas as transportadoras do Nordeste.
	transportadoras: set Transportadora
}

-- Assinatura de uma transportadora genérica, todas possuem um set de caminhão
abstract sig Transportadora {
	caminhoes: set Caminhao
}

-- Assinatura das transportadoras específicas de cada estado do Nordeste
one sig TransportadoraPB extends Transportadora {}
one sig	TransportadoraPE extends Transportadora {}
one sig TransportadoraRN extends Transportadora {}
one sig TransportadoraAL extends Transportadora {}
one sig TransportadoraSE extends Transportadora {}
one sig TransportadoraBA extends Transportadora {}
one sig TransportadoraCE extends Transportadora {}
one sig TransportadoraPI extends Transportadora {}
one sig TransportadoraMA extends Transportadora {}

-- Criando caminhão(ões) para o transporte de pedidos
sig Caminhao {
	pedidos: set Pedido
}

sig Pedido{
--Pedido tem apenas um documento (frete)
documento: one Documento,
status: one Status
}

abstract sig Destino{}

one sig PB extends Destino {}
one sig PE extends Destino {}
one sig RN extends Destino {}
one sig AL extends Destino {}
one sig SE extends Destino {}
one sig BA extends Destino {}
one sig CE extends Destino {}
one sig PI extends Destino {}
one sig MA extends Destino {}

abstract sig Status{}

sig EmRota extends Status{}
sig Entregue extends Status{}

sig Documento {
destino: one Destino
}

-- Funções Auxiliares

-- Retorna o destino de um pedido
fun getDestinoDoPedido[p: Pedido] : Destino {
	p.documento.destino
}

-- Retorna os pedidos de um caminhão

fun getPedidosDoCaminhao[c: Caminhao]: Pedido {
	c.pedidos
}

-- Retorna os caminhoes de uma transportadora

fun getCaminhoes[t: Transportadora]: Caminhao {
	t.caminhoes
}

fun getDocumentoDoPedido[p: Pedido]: Documento{
	p.documento
}

fact Pedido {
	--Obrigando os pedidos a estarem relacionados a um caminhao.
	all p:Pedido | one p.~pedidos
}

fact Status{
	all s:Status | one s.~status
}

fact Documento {
	--Obrigando a todo documento estar relacionado a um pedido.
	all d:Documento | one d.~documento
}

fact Caminhao {
	--Obrigando a todo caminhao estar relacionado a uma transportadora.
	all c:Caminhao | one c.~caminhoes
	
}

fact Transportadora {
	--Obrigando a transportadora estar relacionada a central de transportadoras.
	all t:Transportadora | one t.~transportadoras
}


fact Destino {
	--Obrigando a todo destino estar relacionado a um documento
	all d:Destino | one d.~destino
}

-- Predicados

pred documentoEstaEmPedido[d: Documento, p: Pedido]{
		d in p.documento
}

pred pedidoTemUmDestino[p: Pedido, d: Destino]{
	d in p.documento.destino
}

pred pedidoTemUmStatus[p: Pedido, s: Status]{
	s in p.status
}

-- Asserções

assert todosOsPedidosTemDocumento {all p: Pedido | one d: Documento | documentoEstaEmPedido[d, p]}

assert todosOsPedidosTemUmDestino {all p: Pedido | one d: Destino | pedidoTemUmDestino[p,d]}

assert todosOsPedidosTemUmStatus {all p: Pedido | one s: Status | pedidoTemUmStatus[p,s]}

pred show[]{}
run show for 9
