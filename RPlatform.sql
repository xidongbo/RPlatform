DROP TABLE IF EXISTS `userinfo`;
create table `userinfo`(
	`id` int(13) auto_increment  not null primary key,
	`username` varchar(20)not null,
	`userpwd` varchar(20) not null,
	`name` varchar(20) not null,
	`email` varchar(20) not null
);
DROP TABLE IF EXISTS `analysis_record`;
create table `analysis_record`(
     `id` int(13) auto_increment  not null primary key,
     `username` varchar(20)not null,
     `input_table` varchar(100)not null,
     `output_table` varchar(100)not null,
     `pic_path1` varchar(100)null,
     `pic_path2` varchar(100)null
);
DROP TABLE IF EXISTS `analysis_data`;
create table `analysis_data`(
     `id` int(13) auto_increment  not null primary key,
     `username` varchar(20)not null,
     `input_table` varchar(100)not null
);