
drop database oficina;
create database oficina;
use oficina;
create table cliente(
	CPF_cliente char(11) not null primary key,
	nome_cliente varchar(50) not null,
	endereco_cliente varchar(60) not null,
	contato char(15) not null
);

create table equipeMecanico(
	id_mecanico int auto_increment primary key,
    nome varchar(45) not null,
    especialidade enum('Montador', 'Manutenção','Conserto'),
    endereco_mecanico varchar(60)
);


create table veiculo(
	id_veiculo int auto_increment primary key,
    placa char(7) not null,
    CPF_clienteVeiculo char(11) not null,
    id_veiculoResp int not null,
    desc_servico varchar(255) not null,
    marca varchar(30),
    modelo varchar(60),
    ano year,
    constraint placa_unique unique(placa),
    constraint fk_idVeiculoResp foreign key (id_veiculoResp) references equipeMecanico(id_mecanico),
    constraint fk_idVeiculoCliente foreign key (CPF_clienteVeiculo) references cliente(CPF_cliente)
);

create table ordemServico(
	id_ordemServico int auto_increment primary key,
    id_ordemVeiculo int,
    StatusOS enum('Em análise', 'Em operação', 'Finalizado'),
    dt_emissao date not null,
    dt_entrega date default null,
	constraint fk_idVeiculoOrdem foreign key (id_ordemVeiculo) references veiculo(id_veiculo)

);


create table pecas(
	id_pecas int auto_increment primary key,
	nome_peca varchar(45) not null,
    marca_peca varchar(30) not null,
    valor float not null
);

create table servico_maoObra(
	id_tipoServico int auto_increment primary key,
	desc_servico varchar(255) not null,
    valor float default 0
);


create table mecanicoOS(
	id_MOmecanico int,
	id_MOordem int,
    primary key (id_MOmecanico, id_MOordem),
	constraint fk_mecanico_mecanico foreign key (id_MOmecanico) references equipeMecanico(id_mecanico),
	constraint fk_mecanico_OS foreign key (id_MOordem) references ordemServico(id_ordemServico)
);

create table maoObraOS(
	id_OOos int,
	id_OOobra int,
    primary key (id_OOos, id_OOobra),
	constraint fk_obra_obra foreign key (id_OOobra) references servico_maoObra(id_tipoServico),
	constraint fk_obra_ordem foreign key (id_OOos) references ordemServico(id_ordemServico)
);

create table pecaOS(
	id_POos int,
	id_POpeca int,
    quantidade_peca int default 1,
    primary key (id_POos, id_POpeca),
	constraint fk_peca_peca foreign key (id_POpeca) references pecas(id_pecas),
	constraint fk_peca_ordem foreign key (id_POos) references ordemServico(id_ordemServico)
);