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
-- Data for Name: cor1440_gen_actividadtipo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'ORGANIZACIÓN DE ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:47:31.920052', '2015-04-17 21:47:31.920052');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'ORGANIZACIÓN DE CAMPAÑA', '', '2015-04-18', NULL, '2015-04-18 10:58:02.08154', '2015-04-18 10:58:02.08154');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (11, 'MISIÓN HUMANITARIA', '', '2015-04-18', NULL, '2015-04-18 10:58:22.231407', '2015-04-18 10:58:22.231407');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (12, 'SEGUIMIENTO A CASO', '', '2015-04-18', NULL, '2015-04-18 10:58:52.741712', '2015-04-18 10:58:52.741712');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'SEGUIMIENTO A PLANEACIÓN,', '', '2015-04-18', NULL, '2015-04-18 10:59:06.40352', '2015-04-18 10:59:06.40352');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (14, 'SEGUIMIENTO A PROYECTO', '', '2015-04-18', NULL, '2015-04-18 10:59:21.721801', '2015-04-18 10:59:21.721801');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (15, 'VISITA TÉCNICA', '', '2015-04-18', NULL, '2015-04-18 10:59:42.391942', '2015-04-18 10:59:42.391942');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'PARTICIPACIÓN EN ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:35.802212', '2015-04-17 21:52:35.802212');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'PARTICIPACIÓN EN REUNIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:48.803678', '2015-04-17 21:52:48.803678');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'PARTICIPACIÓN EN REUNIÓN ESTRATÉGICA', '', '2015-04-17', NULL, '2015-04-17 21:53:01.021493', '2015-04-17 21:53:01.021493');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'PRESENTACIÓN DE PONENCIA EN EVENTO', '', '2015-04-17', NULL, '2015-04-17 21:53:13.22205', '2015-04-17 21:53:13.22205');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'MONITOREO, SUPERVISIÓN, EVALUACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:53:26.363204', '2015-04-18 11:01:13.499746');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'ORGANIZACIÓN DE EVENTO', '', '2015-04-18', NULL, '2015-04-18 10:54:24.247319', '2015-04-18 10:54:24.247319');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'RESPUESTA A SOLICITUD DE INFORMACIÓN', '', '2015-04-18', NULL, '2015-04-18 10:56:01.181889', '2015-04-18 11:00:33.221088');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'ORGANIZACIÓN DE ACTIVIDAD CULTURAL/ARTÍSTICA', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');


--
-- Name: cor1440_gen_actividadtipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_actividadtipo_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--

