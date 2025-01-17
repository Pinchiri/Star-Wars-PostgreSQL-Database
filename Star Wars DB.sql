PGDMP                         {            star_wars_db    15.3    15.3 �    4           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            5           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            6           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            7           1262    17775    star_wars_db    DATABASE     �   CREATE DATABASE star_wars_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Venezuela.1252';
    DROP DATABASE star_wars_db;
                postgres    false            v           1247    17777 	   dieta_dom    DOMAIN     s  CREATE DOMAIN public.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Herbívoro'::character varying)::text, ('Carnívoro'::character varying)::text, ('Omnívoros'::character varying)::text, ('Carroñeros'::character varying)::text, ('Geófagos'::character varying)::text, ('Electrófago'::character varying)::text])));
    DROP DOMAIN public.dieta_dom;
       public          postgres    false            z           1247    17780 
   genero_dom    DOMAIN       CREATE DOMAIN public.genero_dom AS character varying(5)
	CONSTRAINT genero_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text, ('Desc'::character varying)::text, ('Otro'::character varying)::text])));
    DROP DOMAIN public.genero_dom;
       public          postgres    false            ~           1247    17783    medio_tipo_ps_dom    DOMAIN     �   CREATE DOMAIN public.medio_tipo_ps_dom AS character varying(15)
	CONSTRAINT medio_tipo_ps_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Animada'::character varying)::text, ('Live-action'::character varying)::text, ('Otro'::character varying)::text])));
 &   DROP DOMAIN public.medio_tipo_ps_dom;
       public          postgres    false            �           1247    17786    tipo_actor_dom    DOMAIN     �   CREATE DOMAIN public.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Interpreta'::character varying)::text, ('Presta su voz'::character varying)::text])));
 #   DROP DOMAIN public.tipo_actor_dom;
       public          postgres    false            �           1247    17789    tipo_af_dom    DOMAIN     �   CREATE DOMAIN public.tipo_af_dom AS character varying(20)
	CONSTRAINT tipo_af_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Organización'::character varying)::text, ('Facción'::character varying)::text, ('Gobierno'::character varying)::text])));
     DROP DOMAIN public.tipo_af_dom;
       public          postgres    false            �           1247    17792    tipo_tripulacion_dom    DOMAIN     (  CREATE DOMAIN public.tipo_tripulacion_dom AS character varying(20)
	CONSTRAINT tipo_tripulacion_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Piloto'::character varying)::text, ('Copiloto'::character varying)::text, ('Artillero'::character varying)::text, ('Otro'::character varying)::text])));
 )   DROP DOMAIN public.tipo_tripulacion_dom;
       public          postgres    false                       1255    17794    calculo_ganancia()    FUNCTION     S  CREATE FUNCTION public.calculo_ganancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.Ganancia = NEW.Ingreso_taquilla - NEW.coste_prod;
	IF NEW.Ganancia < 0 THEN
		RAISE WARNING 'Los Ingresos que ha ingresado son menores que los Costes de Producción, por lo tanto la ganancia será negativa';
	END IF;
RETURN NEW;
END;

$$;
 )   DROP FUNCTION public.calculo_ganancia();
       public          postgres    false                       1255    17795    validar_modelo_nave()    FUNCTION     `  CREATE FUNCTION public.validar_modelo_nave() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (NEW.Modelo = 'Destructor Estelar') AND ((NEW.Longitud < 900) OR (NEW.Uso != 'Combate')) THEN
RAISE EXCEPTION 'Los Destructores Estelares deben tener una longitud mayor a 900 metros y su uso es únicamente de Combate';
	END IF;
	RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.validar_modelo_nave();
       public          postgres    false            �            1259    17796    actor    TABLE       CREATE TABLE public.actor (
    nombre_actor character varying(255) NOT NULL,
    apellido_actor character varying(255) NOT NULL,
    fecha_nacimiento character varying(255),
    nacionalidad character varying(255),
    genero public.genero_dom,
    tipo public.tipo_actor_dom
);
    DROP TABLE public.actor;
       public         heap    postgres    false    890    898            �            1259    17801 
   afiliacion    TABLE     �   CREATE TABLE public.afiliacion (
    nombre_af character varying(255) NOT NULL,
    tipo_af public.tipo_af_dom,
    nombre_planeta character varying(255)
);
    DROP TABLE public.afiliacion;
       public         heap    postgres    false    902            �            1259    17806    afiliado    TABLE     �   CREATE TABLE public.afiliado (
    nombre_af character varying(255) NOT NULL,
    fecha_af date NOT NULL,
    nombre_personaje character varying(255) NOT NULL
);
    DROP TABLE public.afiliado;
       public         heap    postgres    false            �            1259    17811    aparece    TABLE     t   CREATE TABLE public.aparece (
    nombre_personaje character varying(255) NOT NULL,
    idmedio integer NOT NULL
);
    DROP TABLE public.aparece;
       public         heap    postgres    false            �            1259    17814    aparece_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.aparece_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.aparece_idmedio_seq;
       public          postgres    false    217            8           0    0    aparece_idmedio_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.aparece_idmedio_seq OWNED BY public.aparece.idmedio;
          public          postgres    false    218            �            1259    17815    ciudad    TABLE     �   CREATE TABLE public.ciudad (
    nombre_ciudad character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.ciudad;
       public         heap    postgres    false            �            1259    17820    combate    TABLE     �   CREATE TABLE public.combate (
    participante1 character varying(255) NOT NULL,
    participante2 character varying(255) NOT NULL,
    idmedio integer NOT NULL,
    fecha_combate date NOT NULL,
    lugar_combate character varying(255)
);
    DROP TABLE public.combate;
       public         heap    postgres    false            �            1259    17825    combate_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.combate_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.combate_idmedio_seq;
       public          postgres    false    220            9           0    0    combate_idmedio_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.combate_idmedio_seq OWNED BY public.combate.idmedio;
          public          postgres    false    221            �            1259    17826    origen    TABLE     �   CREATE TABLE public.origen (
    nombre_personaje character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.origen;
       public         heap    postgres    false            �            1259    17831 	   personaje    TABLE     f  CREATE TABLE public.personaje (
    nombre_personaje character varying(255) NOT NULL,
    nombre_planeta character varying(255),
    genero public.genero_dom,
    altura double precision,
    peso double precision,
    id_especie integer NOT NULL,
    CONSTRAINT alturapeso_ck CHECK (((altura > (0)::double precision) AND (peso > (0)::double precision)))
);
    DROP TABLE public.personaje;
       public         heap    postgres    false    890            �            1259    17837    planeta    TABLE     �   CREATE TABLE public.planeta (
    nombre_planeta character varying(255) NOT NULL,
    sistema_solar character varying(255) NOT NULL,
    sector character varying(255),
    clima character varying(255)
);
    DROP TABLE public.planeta;
       public         heap    postgres    false            �            1259    17842 	   consulta1    VIEW     �  CREATE VIEW public.consulta1 AS
 SELECT DISTINCT p.nombre_planeta,
    pr.nombre_personaje
   FROM (((public.planeta p
     JOIN public.afiliacion a ON (((p.nombre_planeta)::text = (a.nombre_planeta)::text)))
     JOIN public.personaje pr ON (((p.nombre_planeta)::text = (pr.nombre_planeta)::text)))
     JOIN public.origen o ON ((((pr.nombre_personaje)::text = (o.nombre_personaje)::text) AND ((p.nombre_planeta)::text = (o.nombre_planeta)::text))))
  WHERE ((a.nombre_af)::text = 'Jedi'::text);
    DROP VIEW public.consulta1;
       public          postgres    false    223    222    222    215    223    215    224            �            1259    17847    medio    TABLE       CREATE TABLE public.medio (
    id integer NOT NULL,
    titulo character varying(255),
    fecha_estreno date,
    rating double precision,
    sinopsis text,
    CONSTRAINT rating_ck CHECK (((rating <= (5)::double precision) AND (rating >= (1)::double precision)))
);
    DROP TABLE public.medio;
       public         heap    postgres    false            �            1259    17853    serie    TABLE     �   CREATE TABLE public.serie (
    idmedio integer NOT NULL,
    nombre_creador character varying(255),
    apellido_creador character varying(255),
    total_episodio integer,
    canal character varying(255),
    tipo_serie public.medio_tipo_ps_dom
);
    DROP TABLE public.serie;
       public         heap    postgres    false    894            �            1259    17858 	   consulta2    VIEW     Q  CREATE VIEW public.consulta2 AS
 SELECT s.idmedio,
    m.titulo,
    s.tipo_serie,
    s.nombre_creador,
    s.apellido_creador,
    s.total_episodio
   FROM (public.serie s
     JOIN public.medio m ON ((s.idmedio = m.id)))
  WHERE ((s.total_episodio)::numeric > ( SELECT avg(serie.total_episodio) AS avg
           FROM public.serie));
    DROP VIEW public.consulta2;
       public          postgres    false    226    226    227    227    227    227    227    894            �            1259    17863 	   consulta3    VIEW     �   CREATE VIEW public.consulta3 AS
 SELECT m.titulo AS medio,
    c.lugar_combate,
    count(*) AS cantidad_combates
   FROM (public.combate c
     JOIN public.medio m ON ((c.idmedio = m.id)))
  GROUP BY m.titulo, c.lugar_combate;
    DROP VIEW public.consulta3;
       public          postgres    false    220    220    226    226            �            1259    17867    pelicula    TABLE        CREATE TABLE public.pelicula (
    idmedio integer NOT NULL,
    duracion integer,
    distribuidor character varying(255),
    coste_prod double precision,
    tipo_pelicula public.medio_tipo_ps_dom,
    ingreso_taquilla double precision,
    ganancia double precision,
    nombre_director character varying(255),
    apellido_director character varying(255),
    CONSTRAINT pelicula_valores_ck CHECK (((duracion > 0) AND (coste_prod > (0)::double precision) AND (ingreso_taquilla > (0)::double precision)))
);
    DROP TABLE public.pelicula;
       public         heap    postgres    false    894            �            1259    17873 	   consulta4    VIEW       CREATE VIEW public.consulta4 AS
 SELECT p.idmedio,
    m.titulo,
    m.fecha_estreno,
    p.duracion,
    p.coste_prod,
    p.ingreso_taquilla,
    p.ganancia
   FROM (public.pelicula p
     JOIN public.medio m ON ((p.idmedio = m.id)))
  WHERE ((p.duracion > 150) AND ((p.tipo_pelicula)::text = 'Animada'::text) AND (p.ganancia > ( SELECT avg(pelicula.ganancia) AS avg
           FROM public.pelicula
          WHERE ((pelicula.tipo_pelicula)::text = 'Animada'::text))))
  ORDER BY p.coste_prod, m.fecha_estreno;
    DROP VIEW public.consulta4;
       public          postgres    false    230    230    230    230    230    226    230    226    226            �            1259    17878    dueño    TABLE     �   CREATE TABLE public."dueño" (
    id_nave integer NOT NULL,
    nombre_personaje character varying(255) NOT NULL,
    fecha_compra date NOT NULL
);
    DROP TABLE public."dueño";
       public         heap    postgres    false            �            1259    17881    nave    TABLE     �   CREATE TABLE public.nave (
    id_nave integer NOT NULL,
    nombre_nave character varying(255),
    fabricante character varying(255),
    longitud double precision,
    uso character varying(255),
    modelo character varying(255)
);
    DROP TABLE public.nave;
       public         heap    postgres    false                       1259    18196 	   consulta5    VIEW     W  CREATE VIEW public.consulta5 AS
 SELECT n.nombre_nave,
    n.fabricante,
    n.longitud,
    n.uso,
    n.modelo,
    p.nombre_personaje,
    count(*) AS cantidad_apariciones
   FROM (((public.nave n
     JOIN public."dueño" d ON ((n.id_nave = d.id_nave)))
     JOIN public.personaje p ON (((d.nombre_personaje)::text = (p.nombre_personaje)::text)))
     JOIN public.aparece ae ON (((p.nombre_personaje)::text = (ae.nombre_personaje)::text)))
  WHERE ((n.uso)::text = 'Carguero'::text)
  GROUP BY n.nombre_nave, n.fabricante, n.longitud, n.uso, n.modelo, p.nombre_personaje
 HAVING (count(*) > 2);
    DROP VIEW public.consulta5;
       public          postgres    false    233    233    233    233    217    223    232    232    233    233            �            1259    17891 	   consulta6    VIEW     �   CREATE VIEW public.consulta6 AS
 SELECT p.nombre_planeta,
    p.clima,
    p.sector,
    p.sistema_solar
   FROM public.planeta p
  WHERE ((p.sistema_solar)::text = 'Sistema de Coruscant'::text);
    DROP VIEW public.consulta6;
       public          postgres    false    224    224    224    224            �            1259    17895    robot    TABLE     �   CREATE TABLE public.robot (
    id_especie integer NOT NULL,
    creador character varying(255),
    clase character varying(255)
);
    DROP TABLE public.robot;
       public         heap    postgres    false            �            1259    17900 	   consulta7    VIEW     �  CREATE VIEW public.consulta7 AS
 SELECT r.clase,
    r.creador
   FROM (((public.robot r
     JOIN public.personaje p ON (((r.creador)::text = (p.nombre_personaje)::text)))
     JOIN public.afiliacion a ON (((a.nombre_af)::text = 'Jedi'::text)))
     JOIN public.afiliado f ON ((((f.nombre_af)::text = (a.nombre_af)::text) AND ((f.nombre_personaje)::text = (p.nombre_personaje)::text))));
    DROP VIEW public.consulta7;
       public          postgres    false    235    216    215    216    223    235            �            1259    17905    interpretado    TABLE     �   CREATE TABLE public.interpretado (
    nombre_personaje character varying(255) NOT NULL,
    nombre_actor character varying(255) NOT NULL,
    apellido_actor character varying(255) NOT NULL,
    id_medio integer NOT NULL
);
     DROP TABLE public.interpretado;
       public         heap    postgres    false            �            1259    17910 	   consulta8    VIEW     �  CREATE VIEW public.consulta8 AS
 SELECT DISTINCT a.nombre_actor,
    a.apellido_actor
   FROM ((((public.actor a
     JOIN public.interpretado i ON (((a.nombre_actor)::text = (i.nombre_actor)::text)))
     JOIN public.personaje p ON (((i.nombre_personaje)::text = (p.nombre_personaje)::text)))
     JOIN public.afiliacion af ON (((af.nombre_af)::text = 'Jedi'::text)))
     JOIN public.afiliado f ON (((p.nombre_personaje)::text = (f.nombre_personaje)::text)))
  WHERE ((a.genero)::text = 'M'::text);
    DROP VIEW public.consulta8;
       public          postgres    false    216    214    214    214    215    223    237    237            �            1259    17915    criatura    TABLE     �   CREATE TABLE public.criatura (
    id_especie integer NOT NULL,
    color_piel character varying(255),
    dieta public.dieta_dom
);
    DROP TABLE public.criatura;
       public         heap    postgres    false    886            �            1259    17920    criatura_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.criatura_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.criatura_id_especie_seq;
       public          postgres    false    239            :           0    0    criatura_id_especie_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.criatura_id_especie_seq OWNED BY public.criatura.id_especie;
          public          postgres    false    240            �            1259    17921    dueño_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public."dueño_id_nave_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."dueño_id_nave_seq";
       public          postgres    false    232            ;           0    0    dueño_id_nave_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."dueño_id_nave_seq" OWNED BY public."dueño".id_nave;
          public          postgres    false    241            �            1259    17922    especie    TABLE     d   CREATE TABLE public.especie (
    idioma character varying(255),
    id_especie integer NOT NULL
);
    DROP TABLE public.especie;
       public         heap    postgres    false            �            1259    17925    especie_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.especie_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.especie_id_especie_seq;
       public          postgres    false    242            <           0    0    especie_id_especie_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.especie_id_especie_seq OWNED BY public.especie.id_especie;
          public          postgres    false    243            �            1259    17926    humano    TABLE     �   CREATE TABLE public.humano (
    id_especie integer NOT NULL,
    fecha_nacimiento date,
    fecha_muerte date,
    CONSTRAINT fecha_muerte_ck CHECK ((fecha_nacimiento < fecha_muerte))
);
    DROP TABLE public.humano;
       public         heap    postgres    false            �            1259    17930    humano_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.humano_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.humano_id_especie_seq;
       public          postgres    false    244            =           0    0    humano_id_especie_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.humano_id_especie_seq OWNED BY public.humano.id_especie;
          public          postgres    false    245            �            1259    17931    idiomas    TABLE     �   CREATE TABLE public.idiomas (
    idioma character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.idiomas;
       public         heap    postgres    false            �            1259    17936    lugares_interes    TABLE     �   CREATE TABLE public.lugares_interes (
    lugar character varying(255) NOT NULL,
    nombre_ciudad character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
 #   DROP TABLE public.lugares_interes;
       public         heap    postgres    false            �            1259    17941    medio_id_seq    SEQUENCE     �   CREATE SEQUENCE public.medio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.medio_id_seq;
       public          postgres    false    226            >           0    0    medio_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.medio_id_seq OWNED BY public.medio.id;
          public          postgres    false    248            �            1259    17942    nave_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public.nave_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.nave_id_nave_seq;
       public          postgres    false    233            ?           0    0    nave_id_nave_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.nave_id_nave_seq OWNED BY public.nave.id_nave;
          public          postgres    false    249            �            1259    17943    pelicula_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.pelicula_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pelicula_idmedio_seq;
       public          postgres    false    230            @           0    0    pelicula_idmedio_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.pelicula_idmedio_seq OWNED BY public.pelicula.idmedio;
          public          postgres    false    250            �            1259    17944    personaje_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.personaje_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.personaje_id_especie_seq;
       public          postgres    false    223            A           0    0    personaje_id_especie_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.personaje_id_especie_seq OWNED BY public.personaje.id_especie;
          public          postgres    false    251            �            1259    17945    plataformas    TABLE     q   CREATE TABLE public.plataformas (
    idmedio integer NOT NULL,
    plataforma character varying(50) NOT NULL
);
    DROP TABLE public.plataformas;
       public         heap    postgres    false            �            1259    17948    plataformas_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.plataformas_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.plataformas_idmedio_seq;
       public          postgres    false    252            B           0    0    plataformas_idmedio_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.plataformas_idmedio_seq OWNED BY public.plataformas.idmedio;
          public          postgres    false    253            �            1259    17949    robot_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.robot_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.robot_id_especie_seq;
       public          postgres    false    235            C           0    0    robot_id_especie_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.robot_id_especie_seq OWNED BY public.robot.id_especie;
          public          postgres    false    254            �            1259    17950    sede_principal    TABLE     �   CREATE TABLE public.sede_principal (
    nombre_af character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
 "   DROP TABLE public.sede_principal;
       public         heap    postgres    false                        1259    17955    serie_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.serie_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.serie_idmedio_seq;
       public          postgres    false    227            D           0    0    serie_idmedio_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.serie_idmedio_seq OWNED BY public.serie.idmedio;
          public          postgres    false    256                       1259    17956    tripula    TABLE     �   CREATE TABLE public.tripula (
    id_nave integer NOT NULL,
    nombre_personaje character varying(255) NOT NULL,
    tipo_tripulacion public.tipo_tripulacion_dom
);
    DROP TABLE public.tripula;
       public         heap    postgres    false    906                       1259    17961    tripula_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public.tripula_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tripula_id_nave_seq;
       public          postgres    false    257            E           0    0    tripula_id_nave_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tripula_id_nave_seq OWNED BY public.tripula.id_nave;
          public          postgres    false    258                       1259    17962 
   videojuego    TABLE     �   CREATE TABLE public.videojuego (
    idmedio integer NOT NULL,
    tipo_juego character varying(255),
    "compañia" character varying(255)
);
    DROP TABLE public.videojuego;
       public         heap    postgres    false                       1259    17967    videojuego_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.videojuego_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.videojuego_idmedio_seq;
       public          postgres    false    259            F           0    0    videojuego_idmedio_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.videojuego_idmedio_seq OWNED BY public.videojuego.idmedio;
          public          postgres    false    260                       2604    17968    aparece idmedio    DEFAULT     r   ALTER TABLE ONLY public.aparece ALTER COLUMN idmedio SET DEFAULT nextval('public.aparece_idmedio_seq'::regclass);
 >   ALTER TABLE public.aparece ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    218    217                       2604    17969    combate idmedio    DEFAULT     r   ALTER TABLE ONLY public.combate ALTER COLUMN idmedio SET DEFAULT nextval('public.combate_idmedio_seq'::regclass);
 >   ALTER TABLE public.combate ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    221    220                       2604    17970    criatura id_especie    DEFAULT     z   ALTER TABLE ONLY public.criatura ALTER COLUMN id_especie SET DEFAULT nextval('public.criatura_id_especie_seq'::regclass);
 B   ALTER TABLE public.criatura ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    240    239                       2604    17971    dueño id_nave    DEFAULT     t   ALTER TABLE ONLY public."dueño" ALTER COLUMN id_nave SET DEFAULT nextval('public."dueño_id_nave_seq"'::regclass);
 ?   ALTER TABLE public."dueño" ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    241    232                       2604    17972    especie id_especie    DEFAULT     x   ALTER TABLE ONLY public.especie ALTER COLUMN id_especie SET DEFAULT nextval('public.especie_id_especie_seq'::regclass);
 A   ALTER TABLE public.especie ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    243    242                       2604    17973    humano id_especie    DEFAULT     v   ALTER TABLE ONLY public.humano ALTER COLUMN id_especie SET DEFAULT nextval('public.humano_id_especie_seq'::regclass);
 @   ALTER TABLE public.humano ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    245    244                       2604    17974    medio id    DEFAULT     d   ALTER TABLE ONLY public.medio ALTER COLUMN id SET DEFAULT nextval('public.medio_id_seq'::regclass);
 7   ALTER TABLE public.medio ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    248    226                       2604    17975    nave id_nave    DEFAULT     l   ALTER TABLE ONLY public.nave ALTER COLUMN id_nave SET DEFAULT nextval('public.nave_id_nave_seq'::regclass);
 ;   ALTER TABLE public.nave ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    249    233                       2604    17976    pelicula idmedio    DEFAULT     t   ALTER TABLE ONLY public.pelicula ALTER COLUMN idmedio SET DEFAULT nextval('public.pelicula_idmedio_seq'::regclass);
 ?   ALTER TABLE public.pelicula ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    250    230                       2604    17977    personaje id_especie    DEFAULT     |   ALTER TABLE ONLY public.personaje ALTER COLUMN id_especie SET DEFAULT nextval('public.personaje_id_especie_seq'::regclass);
 C   ALTER TABLE public.personaje ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    251    223                       2604    17978    plataformas idmedio    DEFAULT     z   ALTER TABLE ONLY public.plataformas ALTER COLUMN idmedio SET DEFAULT nextval('public.plataformas_idmedio_seq'::regclass);
 B   ALTER TABLE public.plataformas ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    253    252                       2604    17979    robot id_especie    DEFAULT     t   ALTER TABLE ONLY public.robot ALTER COLUMN id_especie SET DEFAULT nextval('public.robot_id_especie_seq'::regclass);
 ?   ALTER TABLE public.robot ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    254    235                       2604    17980    serie idmedio    DEFAULT     n   ALTER TABLE ONLY public.serie ALTER COLUMN idmedio SET DEFAULT nextval('public.serie_idmedio_seq'::regclass);
 <   ALTER TABLE public.serie ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    256    227                       2604    17981    tripula id_nave    DEFAULT     r   ALTER TABLE ONLY public.tripula ALTER COLUMN id_nave SET DEFAULT nextval('public.tripula_id_nave_seq'::regclass);
 >   ALTER TABLE public.tripula ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    258    257                       2604    17982    videojuego idmedio    DEFAULT     x   ALTER TABLE ONLY public.videojuego ALTER COLUMN idmedio SET DEFAULT nextval('public.videojuego_idmedio_seq'::regclass);
 A   ALTER TABLE public.videojuego ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    260    259            
          0    17796    actor 
   TABLE DATA           k   COPY public.actor (nombre_actor, apellido_actor, fecha_nacimiento, nacionalidad, genero, tipo) FROM stdin;
    public          postgres    false    214   ��                 0    17801 
   afiliacion 
   TABLE DATA           H   COPY public.afiliacion (nombre_af, tipo_af, nombre_planeta) FROM stdin;
    public          postgres    false    215   l�                 0    17806    afiliado 
   TABLE DATA           I   COPY public.afiliado (nombre_af, fecha_af, nombre_personaje) FROM stdin;
    public          postgres    false    216   �                 0    17811    aparece 
   TABLE DATA           <   COPY public.aparece (nombre_personaje, idmedio) FROM stdin;
    public          postgres    false    217   ��                 0    17815    ciudad 
   TABLE DATA           ?   COPY public.ciudad (nombre_ciudad, nombre_planeta) FROM stdin;
    public          postgres    false    219   c�                 0    17820    combate 
   TABLE DATA           f   COPY public.combate (participante1, participante2, idmedio, fecha_combate, lugar_combate) FROM stdin;
    public          postgres    false    220   ��                 0    17915    criatura 
   TABLE DATA           A   COPY public.criatura (id_especie, color_piel, dieta) FROM stdin;
    public          postgres    false    239   o�                 0    17878    dueño 
   TABLE DATA           K   COPY public."dueño" (id_nave, nombre_personaje, fecha_compra) FROM stdin;
    public          postgres    false    232   ��                 0    17922    especie 
   TABLE DATA           5   COPY public.especie (idioma, id_especie) FROM stdin;
    public          postgres    false    242   9�       !          0    17926    humano 
   TABLE DATA           L   COPY public.humano (id_especie, fecha_nacimiento, fecha_muerte) FROM stdin;
    public          postgres    false    244   ��       #          0    17931    idiomas 
   TABLE DATA           9   COPY public.idiomas (idioma, nombre_planeta) FROM stdin;
    public          postgres    false    246   U�                 0    17905    interpretado 
   TABLE DATA           `   COPY public.interpretado (nombre_personaje, nombre_actor, apellido_actor, id_medio) FROM stdin;
    public          postgres    false    237   ��       $          0    17936    lugares_interes 
   TABLE DATA           O   COPY public.lugares_interes (lugar, nombre_ciudad, nombre_planeta) FROM stdin;
    public          postgres    false    247   �                 0    17847    medio 
   TABLE DATA           L   COPY public.medio (id, titulo, fecha_estreno, rating, sinopsis) FROM stdin;
    public          postgres    false    226   ��                 0    17881    nave 
   TABLE DATA           W   COPY public.nave (id_nave, nombre_nave, fabricante, longitud, uso, modelo) FROM stdin;
    public          postgres    false    233   �                0    17826    origen 
   TABLE DATA           B   COPY public.origen (nombre_personaje, nombre_planeta) FROM stdin;
    public          postgres    false    222                   0    17867    pelicula 
   TABLE DATA           �   COPY public.pelicula (idmedio, duracion, distribuidor, coste_prod, tipo_pelicula, ingreso_taquilla, ganancia, nombre_director, apellido_director) FROM stdin;
    public          postgres    false    230   I                0    17831 	   personaje 
   TABLE DATA           g   COPY public.personaje (nombre_personaje, nombre_planeta, genero, altura, peso, id_especie) FROM stdin;
    public          postgres    false    223   M                0    17837    planeta 
   TABLE DATA           O   COPY public.planeta (nombre_planeta, sistema_solar, sector, clima) FROM stdin;
    public          postgres    false    224   d      )          0    17945    plataformas 
   TABLE DATA           :   COPY public.plataformas (idmedio, plataforma) FROM stdin;
    public          postgres    false    252   �                0    17895    robot 
   TABLE DATA           ;   COPY public.robot (id_especie, creador, clase) FROM stdin;
    public          postgres    false    235   �      ,          0    17950    sede_principal 
   TABLE DATA           C   COPY public.sede_principal (nombre_af, nombre_planeta) FROM stdin;
    public          postgres    false    255   j	                0    17853    serie 
   TABLE DATA           m   COPY public.serie (idmedio, nombre_creador, apellido_creador, total_episodio, canal, tipo_serie) FROM stdin;
    public          postgres    false    227   �	      .          0    17956    tripula 
   TABLE DATA           N   COPY public.tripula (id_nave, nombre_personaje, tipo_tripulacion) FROM stdin;
    public          postgres    false    257   z
      0          0    17962 
   videojuego 
   TABLE DATA           F   COPY public.videojuego (idmedio, tipo_juego, "compañia") FROM stdin;
    public          postgres    false    259   �
      G           0    0    aparece_idmedio_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.aparece_idmedio_seq', 1, false);
          public          postgres    false    218            H           0    0    combate_idmedio_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.combate_idmedio_seq', 1, false);
          public          postgres    false    221            I           0    0    criatura_id_especie_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.criatura_id_especie_seq', 1, false);
          public          postgres    false    240            J           0    0    dueño_id_nave_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."dueño_id_nave_seq"', 1, false);
          public          postgres    false    241            K           0    0    especie_id_especie_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.especie_id_especie_seq', 5, true);
          public          postgres    false    243            L           0    0    humano_id_especie_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.humano_id_especie_seq', 1, false);
          public          postgres    false    245            M           0    0    medio_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.medio_id_seq', 13, true);
          public          postgres    false    248            N           0    0    nave_id_nave_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.nave_id_nave_seq', 5, true);
          public          postgres    false    249            O           0    0    pelicula_idmedio_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.pelicula_idmedio_seq', 1, false);
          public          postgres    false    250            P           0    0    personaje_id_especie_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.personaje_id_especie_seq', 1, false);
          public          postgres    false    251            Q           0    0    plataformas_idmedio_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.plataformas_idmedio_seq', 1, false);
          public          postgres    false    253            R           0    0    robot_id_especie_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.robot_id_especie_seq', 1, false);
          public          postgres    false    254            S           0    0    serie_idmedio_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.serie_idmedio_seq', 1, false);
          public          postgres    false    256            T           0    0    tripula_id_nave_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tripula_id_nave_seq', 1, false);
          public          postgres    false    258            U           0    0    videojuego_idmedio_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.videojuego_idmedio_seq', 1, false);
          public          postgres    false    260            !           2606    17984    actor actor_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pk PRIMARY KEY (nombre_actor, apellido_actor);
 8   ALTER TABLE ONLY public.actor DROP CONSTRAINT actor_pk;
       public            postgres    false    214    214            #           2606    17986    afiliacion afiliacion_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY public.afiliacion
    ADD CONSTRAINT afiliacion_pk PRIMARY KEY (nombre_af);
 B   ALTER TABLE ONLY public.afiliacion DROP CONSTRAINT afiliacion_pk;
       public            postgres    false    215            %           2606    17988    afiliado afiliado_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_pk PRIMARY KEY (nombre_af, fecha_af, nombre_personaje);
 >   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_pk;
       public            postgres    false    216    216    216            '           2606    17990    aparece aparece_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_pk PRIMARY KEY (nombre_personaje, idmedio);
 <   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_pk;
       public            postgres    false    217    217            )           2606    17992    ciudad ciudad_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pk PRIMARY KEY (nombre_ciudad, nombre_planeta);
 :   ALTER TABLE ONLY public.ciudad DROP CONSTRAINT ciudad_pk;
       public            postgres    false    219    219            +           2606    17994    combate combate_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_pk PRIMARY KEY (participante1, participante2, idmedio, fecha_combate);
 <   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_pk;
       public            postgres    false    220    220    220    220            A           2606    17996    criatura criatura_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.criatura
    ADD CONSTRAINT criatura_pk PRIMARY KEY (id_especie);
 >   ALTER TABLE ONLY public.criatura DROP CONSTRAINT criatura_pk;
       public            postgres    false    239            9           2606    17998    dueño dueño_pk 
   CONSTRAINT     w   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_pk" PRIMARY KEY (id_nave, nombre_personaje, fecha_compra);
 >   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_pk";
       public            postgres    false    232    232    232            C           2606    18000    especie especie_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pk PRIMARY KEY (id_especie);
 <   ALTER TABLE ONLY public.especie DROP CONSTRAINT especie_pk;
       public            postgres    false    242            E           2606    18002    humano humano_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public.humano
    ADD CONSTRAINT humano_pk PRIMARY KEY (id_especie);
 :   ALTER TABLE ONLY public.humano DROP CONSTRAINT humano_pk;
       public            postgres    false    244            G           2606    18004    idiomas idiomas_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_pk PRIMARY KEY (idioma, nombre_planeta);
 <   ALTER TABLE ONLY public.idiomas DROP CONSTRAINT idiomas_pk;
       public            postgres    false    246    246            ?           2606    18006    interpretado interpretado_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_pk PRIMARY KEY (id_medio, nombre_personaje, nombre_actor, apellido_actor);
 F   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_pk;
       public            postgres    false    237    237    237    237            I           2606    18008     lugares_interes lugar_interes_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_pk PRIMARY KEY (lugar, nombre_ciudad, nombre_planeta);
 J   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_pk;
       public            postgres    false    247    247    247            3           2606    18010    medio medio_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.medio
    ADD CONSTRAINT medio_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.medio DROP CONSTRAINT medio_pk;
       public            postgres    false    226            ;           2606    18012    nave nave_pk 
   CONSTRAINT     O   ALTER TABLE ONLY public.nave
    ADD CONSTRAINT nave_pk PRIMARY KEY (id_nave);
 6   ALTER TABLE ONLY public.nave DROP CONSTRAINT nave_pk;
       public            postgres    false    233            -           2606    18014    origen origen_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_pk PRIMARY KEY (nombre_personaje, nombre_planeta);
 :   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_pk;
       public            postgres    false    222    222            7           2606    18016    pelicula pelicula_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pk PRIMARY KEY (idmedio);
 >   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_pk;
       public            postgres    false    230            /           2606    18018    personaje personaje_pk 
   CONSTRAINT     b   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_pk PRIMARY KEY (nombre_personaje);
 @   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_pk;
       public            postgres    false    223            1           2606    18020    planeta planeta_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.planeta
    ADD CONSTRAINT planeta_pk PRIMARY KEY (nombre_planeta);
 <   ALTER TABLE ONLY public.planeta DROP CONSTRAINT planeta_pk;
       public            postgres    false    224            K           2606    18022    plataformas plataformas_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.plataformas
    ADD CONSTRAINT plataformas_pk PRIMARY KEY (plataforma, idmedio);
 D   ALTER TABLE ONLY public.plataformas DROP CONSTRAINT plataformas_pk;
       public            postgres    false    252    252            =           2606    18024    robot robot_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.robot
    ADD CONSTRAINT robot_pk PRIMARY KEY (id_especie);
 8   ALTER TABLE ONLY public.robot DROP CONSTRAINT robot_pk;
       public            postgres    false    235            M           2606    18026     sede_principal sede_principal_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_pk PRIMARY KEY (nombre_af, nombre_planeta);
 J   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_pk;
       public            postgres    false    255    255            5           2606    18028    serie serie_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pk PRIMARY KEY (idmedio);
 8   ALTER TABLE ONLY public.serie DROP CONSTRAINT serie_pk;
       public            postgres    false    227            O           2606    18030    tripula tripula_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_pk PRIMARY KEY (id_nave, nombre_personaje);
 <   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_pk;
       public            postgres    false    257    257            Q           2606    18032    videojuego videojuego_pk 
   CONSTRAINT     [   ALTER TABLE ONLY public.videojuego
    ADD CONSTRAINT videojuego_pk PRIMARY KEY (idmedio);
 B   ALTER TABLE ONLY public.videojuego DROP CONSTRAINT videojuego_pk;
       public            postgres    false    259            r           2620    18033    pelicula calculo_ganancia_tr    TRIGGER     �   CREATE TRIGGER calculo_ganancia_tr BEFORE INSERT OR UPDATE ON public.pelicula FOR EACH ROW EXECUTE FUNCTION public.calculo_ganancia();
 5   DROP TRIGGER calculo_ganancia_tr ON public.pelicula;
       public          postgres    false    230    262            s           2620    18034    nave validar_modelo_nave_tr    TRIGGER     �   CREATE TRIGGER validar_modelo_nave_tr BEFORE INSERT OR UPDATE ON public.nave FOR EACH ROW EXECUTE FUNCTION public.validar_modelo_nave();
 4   DROP TRIGGER validar_modelo_nave_tr ON public.nave;
       public          postgres    false    263    233            S           2606    18035    afiliado afiliado_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_afiliacion_fk FOREIGN KEY (nombre_af) REFERENCES public.afiliacion(nombre_af) ON UPDATE CASCADE ON DELETE SET NULL (nombre_af);
 I   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_afiliacion_fk;
       public          postgres    false    215    3363    216            T           2606    18040    afiliado afiliado_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL (nombre_personaje);
 H   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_personaje_fk;
       public          postgres    false    223    3375    216            U           2606    18045    aparece aparece_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_medio_fk;
       public          postgres    false    217    226    3379            V           2606    18050    aparece aparece_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_personaje_fk;
       public          postgres    false    217    3375    223            W           2606    18055    ciudad ciudad_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.ciudad DROP CONSTRAINT ciudad_planeta_fk;
       public          postgres    false    3377    219    224            X           2606    18060    combate combate_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_medio_fk;
       public          postgres    false    226    220    3379            Y           2606    18065     combate combate_participante2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_participante2_fk FOREIGN KEY (participante2) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_participante2_fk;
       public          postgres    false    3375    223    220            Z           2606    18070 !   combate combate_participantes1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_participantes1_fk FOREIGN KEY (participante1) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_participantes1_fk;
       public          postgres    false    223    3375    220            g           2606    18075    criatura criatura_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.criatura
    ADD CONSTRAINT criatura_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 F   ALTER TABLE ONLY public.criatura DROP CONSTRAINT criatura_especie_fk;
       public          postgres    false    239    3395    242            a           2606    18080    dueño dueño_nave_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_nave_fk" FOREIGN KEY (id_nave) REFERENCES public.nave(id_nave) ON UPDATE CASCADE ON DELETE SET NULL;
 C   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_nave_fk";
       public          postgres    false    3387    233    232            b           2606    18085    dueño dueño_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_personaje_fk" FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 H   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_personaje_fk";
       public          postgres    false    223    232    3375            h           2606    18090    humano humano_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.humano
    ADD CONSTRAINT humano_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 B   ALTER TABLE ONLY public.humano DROP CONSTRAINT humano_especie_fk;
       public          postgres    false    3395    242    244            i           2606    18095    idiomas idiomas_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.idiomas DROP CONSTRAINT idiomas_planeta_fk;
       public          postgres    false    3377    246    224            d           2606    18100 "   interpretado interpretado_actor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_actor_fk FOREIGN KEY (nombre_actor, apellido_actor) REFERENCES public.actor(nombre_actor, apellido_actor) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_actor_fk;
       public          postgres    false    214    3361    237    237    214            e           2606    18105 "   interpretado interpretado_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_medio_fk FOREIGN KEY (id_medio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_medio_fk;
       public          postgres    false    237    3379    226            f           2606    18110 &   interpretado interpretado_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_personaje_fk;
       public          postgres    false    237    3375    223            j           2606    18115 '   lugares_interes lugar_interes_ciudad_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_ciudad_fk FOREIGN KEY (nombre_ciudad, nombre_planeta) REFERENCES public.ciudad(nombre_ciudad, nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 Q   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_ciudad_fk;
       public          postgres    false    247    219    219    3369    247            k           2606    18120 (   lugares_interes lugar_interes_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_planeta_fk;
       public          postgres    false    247    3377    224            [           2606    18125    origen origen_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_personaje_fk;
       public          postgres    false    222    223    3375            \           2606    18130    origen origen_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_planeta_fk;
       public          postgres    false    222    3377    224            `           2606    18135    pelicula pelicula_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_medio_fk;
       public          postgres    false    3379    226    230            ]           2606    18140    personaje personaje_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 H   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_especie_fk;
       public          postgres    false    242    3395    223            ^           2606    18145    personaje personaje_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL (nombre_planeta);
 H   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_planeta_fk;
       public          postgres    false    3377    224    223            R           2606    18150     afiliacion planeta_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliacion
    ADD CONSTRAINT planeta_afiliacion_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.afiliacion DROP CONSTRAINT planeta_afiliacion_fk;
       public          postgres    false    224    215    3377            l           2606    18155 %   plataformas plataformas_videojuego_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.plataformas
    ADD CONSTRAINT plataformas_videojuego_fk FOREIGN KEY (idmedio) REFERENCES public.videojuego(idmedio) ON UPDATE CASCADE ON DELETE SET NULL;
 O   ALTER TABLE ONLY public.plataformas DROP CONSTRAINT plataformas_videojuego_fk;
       public          postgres    false    259    252    3409            c           2606    18160    robot robot_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.robot
    ADD CONSTRAINT robot_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 @   ALTER TABLE ONLY public.robot DROP CONSTRAINT robot_especie_fk;
       public          postgres    false    242    3395    235            m           2606    18165 +   sede_principal sede_principal_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_afiliacion_fk FOREIGN KEY (nombre_af) REFERENCES public.afiliacion(nombre_af) ON UPDATE CASCADE ON DELETE SET NULL;
 U   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_afiliacion_fk;
       public          postgres    false    215    3363    255            n           2606    18170 (   sede_principal sede_principal_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_planeta_fk;
       public          postgres    false    224    255    3377            _           2606    18175    serie serie_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 >   ALTER TABLE ONLY public.serie DROP CONSTRAINT serie_medio_fk;
       public          postgres    false    3379    227    226            o           2606    18180    tripula tripula_nave_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_nave_fk FOREIGN KEY (id_nave) REFERENCES public.nave(id_nave) ON UPDATE CASCADE ON DELETE SET NULL (id_nave);
 A   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_nave_fk;
       public          postgres    false    3387    233    257            p           2606    18185    tripula tripula_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL (nombre_personaje);
 F   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_personaje_fk;
       public          postgres    false    223    3375    257            q           2606    18190    videojuego videojuego_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.videojuego
    ADD CONSTRAINT videojuego_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.videojuego DROP CONSTRAINT videojuego_medio_fk;
       public          postgres    false    226    259    3379            
   �   x�}��
�0��s�{�H۹�E7�` �7/�,n��SЧwŋ�)��O:�gh�h�T�)�%��0�އ���<�����/L��a��;�=�3Zj���/ZGDP�p"���D��Q��Vn:yw��q��[9Jٞ��/�j�H*�C�zG��W
U�{��i^%���CB�'�`T�         �   x�E�1
�@E�S�	��F-���� ��l�ݤȵ�ls1E�4�y�w�c���v�ʄ �K����_h:�7��P$�-¿�8iʒ�8��~~�Q\�Za��v)���O&O����u�4������,b�l�Z�"�5�?�         �   x�mα
�0��9�y�H*��Q**Z���B=H����!J����]G���A�V+�Q��ё����Q�n��l�.��G�H��a���������_k(PB/�����e������J�R�K�V�i�D!��
 ��W@         �   x�e�A
�0EיS��j��X��B��fJ����ܴ����?�W��6㇬� 8Q�;�R�krX{�c,X��I�b������G� �Ǌ]�e�7�����Ì���o?�D
G�������v3	�RI-�䤤J+��?�k��%�e5Qv���#Z	         Z   x�=�;
�0 �99EO�%� ����%j�К@?Co��{�7JI�!P5e��[9I+��p3_��a��R�v��eyC#m	f���> ��%!'         �   x�]��
�0E��W�T��b��҅-
�n���CB*�D��Ͳ��ݜ�E�t���eQ;Hx�c��*�M��uV֪�� �hdJ�#K`}Lv���i0j�a�_ת�S"�hT���jٳ�Q+��S�U��N���B������{8O         _   x�3�K-JI��H-J:��,�(��Ђ�7�����<N�Ģ<��%�{Qf1�.T���Ȁ�/5�(��(���T��!�cUi�{���i��@�=... �%%4         K   x�3��H�S����4�47�50�52�2��I�LT�/JO�KJXC%L9���RKJ@�`aC.#����qqq ���         �   x�U��
�0������	����V,�[�n�6TIZB�� ����3pf4�[��ƿ8��Y�v�q��$���$uI��!�U�y�.���(��E5E�EuE�x̻�:X+�vQ^��e��$*ܶu���<�$�Je      !   w   x�M���@B�c/�#f~6�
��,�� j-��9�uZR��8�e �����"=�r��x)��M�l�D��O��ۿ�#?�e%�1�y�P������Qo��KA.e\?3�2�$�      #   O   x��(-)I-N�L,��S��r-��	�%&��s���gg��rz%fg�r��g�(8e�%Ur:��''�p��qqq �Q         Y   x��)�NUή,O��N-��M,���H�����4��H�S����e��q��� %|R3����9�Ar��n��@�b���� ��J      $   �   x�M�A
�@ϻ����(�4G/�f�!�������L�KSM�@�(�g:��N<���C1�xeEo�G~=S�d���zZ~[d$1�0�z�=����3�fq�u�X$/�I�*Pj����N2rl+{1jl�iQ3�EF��BkGC��M��OlGQ         �  x�m��r�H���)�Vؘ�9�7�]���粗FjØь2#��o�c{�m����=.��2H3�_��w;K��3�𻺮up�v��Q��%e[^��P�'�BI6�N��Y��%��4�%U{m�nY�IUPݴ�J�r^
�e���%U�YS�B"�;2�E�7�I��6�+���'j���Q���s�>��9�@�-�d����*��(��v��a��+�{%O�ׄ�f�h/Tk�_\j�����h=7�[���:�Kw�ܺD�n-�ǌl����z����J��+��R=R�^P&��%��dK2�k�I>�fi��Y�l�����x6PL�՜|A]a�'^3��Њ4xcH-��7M���j)L�A��؝L�����l~��A�qb�@O�㷃�йr;u%+�\�+��d��I �O��F��'qr!v�)��A7K�A||���ź�\o���6�(˶�2�&NB[���!��Ao~�ݱ+�4�@���i'M����U���M���aw���4r�EO]d��as�8.��*D�!{g��O����O����T�a���Jv;2cdd](Z�vt���c��<¼�(z�q�#�4�"�0��n v~z�r\��@uii�m?�����N?C��ٺ��t���V�>���	��y� Q$9H��^M�ɞ��H�W��ie�'6G��@�Ū�k7z�mA��`�9h�Ķ�N�i�@��Z�_׸Ct_w�m���z������ Z���5��cod�؎7 {CM!�g��$nr �VwbҴ�*L���/�n~���8ǫ���ㅚ�^x'˥o��v6�b;�D�$y�Q�l���֨bD��. ~��U����B�/0���`����K�';1@tJ�H�uh���hm��[���C`?G���h�������p��+�T���Y�r���d���K��ټE���З�t��4���k/�+�����B�������%         R  x�m��N�0D�����8����RTH��J\�ɒZr��q@���@EAp�cig��X�S�f\KW�g>�|�h���c��vC�aF��E���H�������:�W�5��}�e��Ϲ��>���p�r��l���N��9b������4�w;�R�pg�e�L��l%����r8w�q�Ar�J4:KG1M����5�p��D��L���$Q�W��OW�����H�j�J�^�Ê6�����!c�e��,U��n�>pױ�C+���*�j�v'd���1Z���<�2��$��vK���D��N]�4y�%���	��&c���O�d:t�a��i�H2��S��G��         $   x�,��u��S�����t�/*-NN�+����� �U�         �   x�m��N� E׏���
�.�Q��$F�n6�%��}Dڎ��L[�)r�¹y�g���d��1Lٽ���K����L58� WT�8��Ы�j8��9���R�;F-���^\Cm�<
��:S`ˀ��:�N���=Ll,���7SJ楦TAQ,�`}��p+�E���7¤�Z�*���L����c�m e2a�z��o��_�-pL�d[�	��V���/�E.fH?o�r�"�� �urx           x�u��N�@���S�4�&�߱P5�*ZB��4����4��ٶ������x͎�f�"!X��"��(�,��S�f���<�+��N���H�(���٩W�ׁ�wt�%�1���a�6o�ݺ�(N��9��C;�%�*�w�Gy(d���;U+ �C�5K��M=8��� y�:���UP�B�w�߆2ԜC��ѫٲ�3���T�i��=LlX�uׂ���%��q��)%X�/���*�щ�>4�$�YS���?#D��k�         /  x���MN�0���)|���Z�TP@��L��x��l9
�^��\W���j$��<ｙ���AN�=g9��5��|˲E(����b�w�_#�x]7JV�,+o��Ԣ��vc,r�$p�FȎ=��x��D��B10 Y���$t�o���Ao���|6j�v+�9Uv�L������PU�T݁a�ǭ������}�C�S����I���E�kgl��&f��pC��wN?
�x�}��]@`&w��@�m�Ȱ��%
��_z��O��f�Q��5���;�S�B��y���۶�z�����7�      )      x�3�p�2�6�I�\1z\\\ 7?�         �   x�34�t�K���Sή,O��N-�t)��LIU ���������|.CN��L���<�Լ��L���⒢������2���L9��t]�pI�q:��c�Ü��I��Vs΀����TN��Ԣ�Ԣ|���k��ҹb���� ��DZ      ,   E   x�JMJ�II-�L,��S��
(��M-JT�/JI��tO���/�,��JM��t�/*-NN�+����� �+         �   x�eαjQ���ܧ�����D,�.
����4�u���̽�!o��р���9%S,ip���$��1�2��YLC�b��ߌu�RB,
T��LG��OxW9ӞB��i`,�3�_o�Ѯ~��>eQld���?TI���,а��Q�q��O�Y�-�X�.�m6�����.�|K?      .   V   x�3��)�NUή,O��N-����/��2��H�S����t�/��s�$�d(�%� ���s�p��f&*��'�%����qqq y�      0   0   x�3�tLN�<�9O7�,5���(��5'5��(?/3Y�����+F��� 0��     