
create table Supervisors(
    supervisorId int generated always as identity,
    supervisorName varchar2(20) not null,
    supervisorLastName varchar2(20) not null,
    constraint pk_idSupervisor primary key (supervisorId)
);

create table Divitions(
    divitionId int generated always as identity,
    divitionName varchar2(20) not null,
    supervisorId int not null,
    constraint pk_idDivition primary key(divitionId),
    constraint fk_divitionSupId foreign key (supervisorId) references Supervisors(supervisorId)
);

create table testTechnicians(
    technicianId int generated always as identity,
    technicianName varchar2(20) not null,
    technicianLastName varchar2(20) not null,
    divitionId int not null,
    constraint pk_idTechnician primary key(technicianId),
    constraint fk_testTechDivition foreign key (divitionId) references Divitions(divitionId)
);

create table reworkSpecialists(
    reworkerId int generated always as identity,
    reworkerName varchar2(20) not null,
    reworkerLastName varchar2(20) not null,
    divitionId int not null,
    constraint pk_idReworker primary key (reworkerId),
    constraint fk_reworkerDivition foreign key (divitionId) references Divitions(divitionId)
);

create table Boards(
    serialNumber varchar2(20) not null,
    partNumber int not null,
    technicianId int not null,
    reworkerId int not null,
    reworkType varchar2(20) not null,
    specialInstructions varchar2(255) not null,
    constraint fk_boardsTestTech foreign key (technicianId) references 
    testTechnicians(technicianId),
    constraint fk_boardsReworker foreign key (reworkerId) references 
    reworkSpecialists(reworkerId)
);

create or replace procedure agregarSupervisor(nombre in varchar2, apellido in varchar2, mensaje out varchar2) 
as
begin
    if length(nombre) > 20 or length(apellido) > 20 then
        mensaje := 'El nombre o el apellido del supervisor contienen mas de 20 caracteres';
    elsif nombre is null or  apellido is null then
        mensaje := 'El nombre o el apellido del supervisor no puede estar vacio';
    else
        insert into Supervisors(supervisorName, supervisorLastName)
        values (nombre, apellido);
        mensaje := 'Se ha registrado correctamente el supervisor'; 
    end if;
end;

create or replace view verSupervisores
as
select supervisorId, supervisorName, supervisorLastName from supervisors;

create or replace procedure llamarVerSupervisores(verSup out sys_refcursor)
as  
begin 
    open verSup for
    select supervisorId, supervisorName, supervisorLastName from verSupervisores;
end;

create or replace procedure modificarSupervisor(idSup in varchar, nombre in varchar2, apellido in varchar2, mensaje out varchar2)
as  
    idSuperNum number;
begin 
    idSuperNum := to_number(idSup);

    if length(nombre) > 20 or length(apellido) > 20 then
        mensaje := 'El nombre o el apellido del supervisor contienen mas de 20 caracteres';
    elsif idSup is null or nombre is null or  apellido is null then
        mensaje := 'El ID, nombre o el apellido del supervisor no puede estar vacio';
    else
        update supervisors
        set supervisorName = nombre,
        supervisorLastName = apellido
        where supervisorId = idSuperNum;
        if SQL%NOTFOUND then
            mensaje := 'No se ha encontrado el supervisor';
        else 
            mensaje := 'Se ha modificado correctamente el supervisor'; 
        end if;
    end if;
    
    exception
    when VALUE_ERROR 
    then
        mensaje := 'Solamente se permite introducir numeros en el ID del supervisor'; 
end;


create or replace procedure eliminarSupervisor(idSup in varchar, mensaje out varchar2)
as  
    idSuperNum number;
begin 
    idSuperNum := to_number(idSup);

    if idSup is null then
        mensaje := 'El ID del supervisor no puede estar vacio';
    else
        delete from supervisors
        where supervisorId = idSuperNum;
        
        if SQL%NOTFOUND then
            mensaje := 'No se ha encontrado el supervisor';
        else 
            mensaje := 'Se ha eliminado correctamente el supervisor'; 
        end if;
    end if;
    
    exception
    when VALUE_ERROR 
    then
        mensaje := 'Solamente se permite introducir numeros en el ID del supervisor'; 
end;


create or replace function buscarSupervisorEspecifico(idSup in varchar2) return varchar2 as
datosSupervisor varchar2(100);
idSuperNum number;
supervisorId supervisors.supervisorId%TYPE;
supervisorName supervisors.supervisorName%TYPE;
supervisorLastName supervisors.supervisorLastName%TYPE;
begin
    idSuperNum := to_number(idSup);
    if idSup is null then
        datosSupervisor := 'EL ID del supervisor no puede estar vacio';
        return datosSupervisor;
    else
        select supervisorId, supervisorName, supervisorLastName into supervisorId, supervisorName, supervisorLastName  from verSupervisores
        where supervisorId = idSuperNum;  
        datosSupervisor := 'ID del Supervisor: ' || supervisorId || ' ' || 'Nombre: ' || supervisorName || ' '  ||
        'Apellido: ' || supervisorLastName;
          return datosSupervisor;
    end if;
    
    exception
    when VALUE_ERROR 
    then
        datosSupervisor := 'Solamente se permite introducir numeros en el ID del supervisor'; 
        return datosSupervisor;
    when NO_DATA_FOUND
    then 
        datosSupervisor := 'No se ha encontrado el supervisor'; 
        return datosSupervisor;
end;

create or replace function buscarSupervisorParaDivisiones return sys_refcursor
as cursorSup sys_refcursor;
begin
    open cursorSup for
    select supervisorId, supervisorName, supervisorLastName from supervisors;
    return cursorSup;
end;


