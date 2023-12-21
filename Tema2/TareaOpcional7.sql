create schema practicando7;
use practicando7;

create table Curso(
	CodCurso int,
	Nombre varchar(40),
	Duracion tinyint,
	coste decimal(7,2)
);

alter table Curso
 modify CodCurso int auto_increment primary key;
 
 create table prerrequisito(
	CursoSolicitado int,
	CursoPrevio int,
    Obligatorio char(1)
	-- Obligatorio boolean
);

alter table prerrequisito
	add primary key (CursoSolicitado, CursoPrevio),
    add foreign key (CursoSolicitado) references Curso (CodCurso),
    add foreign key (CursoPrevio) references Curso (CodCurso),
    add check (upper(Obligatorio) in ('S','N'));
    
create table Empleado(
	CodEmp int,
    NIF char(10),
    Nombre varchar(15),
    Apellidos varchar(20),
    Direccion varchar(40),
    Telefono char(9),
    FechaNac date,
    Salario decimal(8,2)
);

alter table Empleado
	modify CodEmp int auto_increment primary key,
    add unique (NIF),
    add index (Apellidos);
    
create table EmpCapacitado(
	CodEmp int primary key);
    
alter table EmpCapacitado
	add foreign key (CodEmp) references Empleado (CodEmp);
    
create table EmpNoCapacitado(
	CodEmp int primary key);
    
alter table EmpNoCapacitado
	add foreign key (CodEmp) references Empleado (CodEmp);
    
create table Edicion(
	CodCurso int,
    FechaInicio date,
    Lugar varchar(15),
    Horario datetime,
    Profesor int
);

alter table Edicion
	modify CodCurso int auto_increment,
    add index (Lugar),
    add index (Horario),
    add primary key (CodCurso, FechaInicio),
    add foreign key (CodCurso) references Curso (CodCurso),
    add foreign key (Profesor) references EmpCapacitado (CodEmp);
    
create table recibe(
	CodEmpleado int,
    CodCurso int,
    FechaInicio date
);

alter table recibe
	add primary key (CodEmpleado, CodCurso, FechaInicio),
    add foreign key (CodEmpleado) references Empleado (CodEmp),
    add foreign key (CodCurso, FechaInicio) references Edicion (CodCurso, FechaInicio);