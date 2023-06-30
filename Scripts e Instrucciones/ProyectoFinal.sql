
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


