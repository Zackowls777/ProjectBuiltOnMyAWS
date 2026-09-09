create database dzm;

use dzm;

create table `user_info` (
     `id` varchar (36) primary key not null,
     `email` varchar (32) unique not null,
     `username` varchar (32) default "",
     `nickname` varchar (32) default "",
     `password` varchar (100) not null,
     `avatar` varchar (100) default "",
     `role` int default 0,
     `is_deleted` bool default false,
     `created_time` bigint (20) default 0,
     `modified_time` bigint (20) default 0,
     index(`email`)
);

create table `verify_code` (
    `id` varchar (36) primary key not null,
    `type` int default 0,
    `email` varchar (32) not null,
    `code` varchar (10) not null,
    `is_deleted` bool default false,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`email`)
);

create table `channel` (
    `id` varchar (36) primary key not null,
    `creator` varchar (36) not null,
    `title` text,
    `cover` varchar (200) default "",
    `description` text,
    `price` int default 0,
    `inventory` int default 0,
    `is_deleted` bool default false,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`creator`)
);

create table `channel_section`(
    `id` varchar (36) primary key not null,
    `channel` varchar (36) not null,
    `title` text,
    `description` text,
    `cover` varchar (200) default "",
    `video` varchar (200) default "",
    `duration` int default 0,
    `is_deleted` bool default false,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`channel`)
);

create table `subscription_order` (
    `id` varchar (36) primary key not null,
    `user` varchar (36) not null,
    `channel` varchar (36) not null,
    `payment_price` int default 0,
    `status` int default 0,
    `is_deleted` bool default false,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`channel`, `user`),
    index(`user`)
);

create table `paypal_payment` (
    `id` varchar (36) primary key not null,
    `subscription_order` varchar (36) not null,
    `token` varchar (36) default "",
    `approval_url` varchar(100) default "",
    `payer` varchar (36) default "",
    `status` int default 0,
    `is_deleted` bool default false,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`subscription_order`),
    index(`token`)
);

create table `quant_stock_data` (
     `id` varchar (36) primary key not null,
     `symbol` varchar (10) not null,
     `start_day` varchar (10) default "",
     `end_day` varchar (10) default "",
     `data_in_csv` varchar (100) default "",
     `created_time` bigint (20) default 0,
     `modified_time` bigint (20) default 0,
     index(`symbol`, `start_day`, `end_day`)
);

create table `quant_submission` (
    `id` varchar (36) primary key not null,
    `user` varchar (36) not null,
    `symbol` varchar (10) not null,
    `start_day` varchar (10) default "",
    `end_day` varchar (10) default "",
    `code` text,
    `result` int,
    `output` text,
    `created_time` bigint (20) default 0,
    `modified_time` bigint (20) default 0,
    index(`user`, `created_time`)
);