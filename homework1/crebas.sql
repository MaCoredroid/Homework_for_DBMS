/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     4/25/2019 7:23:18 PM                         */
/*==============================================================*/


drop table if exists Bars;

drop table if exists Beers;

drop table if exists Buddy;

drop table if exists Chain;

drop table if exists Drinkers;

drop table if exists Sales;

drop table if exists favourite_bars;

drop table if exists favourite_drinks;

/*==============================================================*/
/* Table: Bars                                                  */
/*==============================================================*/
create table Bars
(
   BarID                varchar(1024) not null,
   Address              varchar(1024) not null,
   City                 varchar(1024) not null,
   State                varchar(1024) not null,
   Opentime             datetime not null,
   Closetime            datetime not null,
   License              varchar(1024) not null,
   Name                 int not null,
   primary key (BarID)
);

/*==============================================================*/
/* Table: Beers                                                 */
/*==============================================================*/
create table Beers
(
   BeerID               int not null,
   Name                 varchar(1024) not null,
   Category             varchar(1024) not null,
   Form                 varchar(1024) not null,
   primary key (BeerID)
);

/*==============================================================*/
/* Table: Buddy                                                 */
/*==============================================================*/
create table Buddy
(
   BuddyID              int not null,
   DrinkerID            int not null,
   primary key (BuddyID, DrinkerID)
);

/*==============================================================*/
/* Table: Chain                                                 */
/*==============================================================*/
create table Chain
(
   ChainID              varchar(1024) not null,
   BarID                varchar(1024) not null,
   primary key (ChainID, BarID)
);

/*==============================================================*/
/* Table: Drinkers                                              */
/*==============================================================*/
create table Drinkers
(
   DrinkerID            int not null,
   Phone                int,
   Address              varchar(1024),
   Name                 varchar(1024),
   City                 varchar(1024),
   State                varchar(1024),
   primary key (DrinkerID)
);

/*==============================================================*/
/* Table: Sales                                                 */
/*==============================================================*/
create table Sales
(
   BarID                varchar(1024) not null,
   BeerID               int not null,
   Price                int,
   Sales                int,
   primary key (BarID, BeerID)
);

/*==============================================================*/
/* Table: favourite_bars                                        */
/*==============================================================*/
create table favourite_bars
(
   BarID                varchar(1024) not null,
   DrinkerID            int not null,
   Frequency            int,
   Total_purchase       int,
   primary key (BarID, DrinkerID)
);

/*==============================================================*/
/* Table: favourite_drinks                                      */
/*==============================================================*/
create table favourite_drinks
(
   BeerID               int not null,
   DrinkerID            int not null,
   Frequency            int,
   primary key (BeerID, DrinkerID)
);

alter table Buddy add constraint FK_Relationship_13 foreign key (DrinkerID)
      references Drinkers (DrinkerID) on delete restrict on update restrict;

alter table Buddy add constraint FK_Relationship_14 foreign key (BuddyID)
      references Drinkers (DrinkerID) on delete restrict on update restrict;

alter table Chain add constraint FK_Relationship_11 foreign key (BarID)
      references Bars (BarID) on delete restrict on update restrict;

alter table Chain add constraint FK_Relationship_12 foreign key (ChainID)
      references Bars (BarID) on delete restrict on update restrict;

alter table Sales add constraint FK_Relationship_8 foreign key (BarID)
      references Bars (BarID) on delete restrict on update restrict;

alter table Sales add constraint FK_Relationship_9 foreign key (BeerID)
      references Beers (BeerID) on delete restrict on update restrict;

alter table favourite_bars add constraint FK_Relationship_2 foreign key (BarID)
      references Bars (BarID) on delete restrict on update restrict;

alter table favourite_bars add constraint FK_Relationship_3 foreign key (DrinkerID)
      references Drinkers (DrinkerID) on delete restrict on update restrict;

alter table favourite_drinks add constraint FK_Relationship_5 foreign key (DrinkerID)
      references Drinkers (DrinkerID) on delete restrict on update restrict;

alter table favourite_drinks add constraint FK_Relationship_6 foreign key (BeerID)
      references Beers (BeerID) on delete restrict on update restrict;

