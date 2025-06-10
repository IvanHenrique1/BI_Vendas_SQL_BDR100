select
notafiscal.codempresa CodigoEmpresa,
empresas.nomeusual NomeUsualEmpresa,
empresas.cgc CNPJEmpresa,
notafiscal.codent CodigoCliente,
entidade.RzSocial RazaoSocialCliente,
entidade.cgc CNPJCliente,
notafiscal.numeronf NumeroNF,
notafiscal.datanf DataEmissaoNF,
notafiscal.valnf ValorTotalNF,
itensnf.valfin ValorFinal,
itensnf.ValorDescontoCondicional ValorDescontoCondicional,
pedido.numped NumeroPedido,
itensnf.codprod CodigoProduto,
itensnf.Descricao Produto,
itensnf.qtde Volume,
itensnf.precoreal PrecoReal,
itensnf.FreteUnitReal FreteUnitario,
notafiscal.retiraentrega RetiraOuEntrega,
itensnf.deposito CodigoDeposito,
deposito.descricao NomeDeposito,
notafiscal.cfop CFOP,
entidade.atividadeeconomica AtividadeEconomica,
notafiscal.valicms ValorICMS,
notafiscal.valipi ValorIPI,
notafiscal.pis PIS,
notafiscal.cofins COFINS,
notafiscal.codtransp CodigoTransportadora,
notafiscal.descricaomotorista NomeMotorista,
notafiscal.placaveitransp PlacaVeiculo,
notafiscal.carreta Carreta,
notafiscal.treminhao Treminhao,

if notafiscal.cancelada = 0 then 'não' else 'sim' endif as Cancelada

from NotaFiscal

inner join
    itensnf on
        notafiscal.sequencial = itensnf.sequencial
        and
        notafiscal.codempresa = itensnf.codempresa

inner join
    empresas on
        notafiscal.codempresa = empresas.codempresa

inner join
    entidade on
        notafiscal.codent = entidade.codent

inner join
    pedido on
        itensnf.numped = pedido.numped
        and
        itensnf.codempresa = pedido.codempresa

inner join
    produto on
        itensnf.codprod = produto.codprod

inner join
    cidade on
        notafiscal.codigodncfat = cidade.codigodnc

inner join
    deposito on
        itensnf.deposito = deposito.coddep

where notafiscal.datanf >= 20250101

and notafiscal.tipopedido = 'VD'

and empresas.nomeusual in ('RODOPETRO CN', 'RODOPETRO RJ DC')