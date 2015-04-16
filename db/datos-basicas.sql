-- Volcado de tablas basicas

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_actividadarea; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'PSICOSOCIAL', '', '2013-12-04', NULL, '2014-01-09 02:23:28.732636', '2014-03-07 18:43:00.812476');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (101, 'COMUNICACIONES', '', '2014-01-29', NULL, '2014-01-29 16:15:43.824216', '2014-03-07 18:43:45.251193');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (103, 'INTEGRACIÓN LOCAL', '', '2014-02-08', NULL, '2014-02-08 13:30:24.014081', '2014-03-07 18:43:56.884996');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (105, 'ACOMPAÑAMIENTO PASTORAL', '', '2014-02-08', NULL, '2014-05-15 21:54:52.38907', '2014-05-15 21:55:15.864721');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'JURÍDICA - LEGAL', '', '2013-12-04', NULL, '2014-01-09 02:23:28.745075', '2014-03-07 18:43:14.269965');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'ORGANIZACIÓN COMUNITARIA', '', '2013-12-04', NULL, '2014-01-09 02:23:28.747505', '2014-03-07 18:44:06.691283');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'EMPRENDIMIENTO', '', '2013-12-04', NULL, '2014-01-09 02:23:28.749798', '2014-03-07 18:43:27.89929');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'INCIDENCIA', '', '2013-12-04', NULL, '2014-01-09 02:23:28.75207', '2014-03-07 18:43:35.753539');


--
-- Name: cor1440_gen_actividadarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_actividadarea_id_seq', 105, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_rangoedadac; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'De 0 a 11', 0, 10, '2014-02-11', NULL, '2014-03-07 19:19:02.690768', NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'De 12 a 17', 0, 10, '2014-02-11', NULL, '2014-03-07 19:19:02.690768', NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'De 18 a 25', 16, 25, '2014-02-11', NULL, '2014-03-07 19:19:09.515802', NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'De 26 a 45', 26, 45, '2014-02-11', NULL, '2014-03-07 19:19:09.527935', NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'De 46 a 60', 46, 60, '2014-02-11', NULL, '2014-03-07 19:19:09.539237', NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'De 61 en adelante', 61, NULL, '2014-02-11', NULL, '2014-03-07 19:19:09.549437', NULL);


--
-- Name: cor1440_gen_rangoedadac_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_rangoedadac_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--


