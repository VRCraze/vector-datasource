SELECT name, kind, haunted, (__geometry__).geom as __geometry__, __id__

FROM
(
	SELECT
	    name,
	    COALESCE("historic", "amenity", "landuse", "tourism", "railway") AS kind,
	    TRUE AS haunted,
	    ST_DumpPoints(way) AS __geometry__,
	    mz_id AS __id__

	FROM planet_osm_polygon

	WHERE name IS NOT NULL
        AND way && !bbox!

	AND (
		landuse = 'cemetery'
		OR amenity IN (
			'grave_yard',
			'crematorium',
                        'library'
		)
		OR historic IN (
			'tomb',
			'castle',
			'archaeological_site',
			'ruins'
		)
		OR railway = 'abandoned'
		OR name IN (
			'Museo de las Momias de Guanajuato',
			'Weston State Hospital'
		)
	)

	UNION

	SELECT
	    name,
	    COALESCE("historic", "amenity", "landuse", "tourism", "railway") AS kind,
	    TRUE AS haunted,
	    ST_DumpPoints(way) AS __geometry__,
	    mz_id AS __id__

	FROM planet_osm_line

	WHERE name IS NOT NULL
        AND way && !bbox!

	AND (
		landuse = 'cemetery'
		OR amenity IN (
			'grave_yard',
			'crematorium',
                        'library'
		)
		OR historic IN (
			'tomb',
			'castle',
			'archaeological_site',
			'ruins'
		)
		OR railway = 'abandoned'
		OR name IN (
			'Museo de las Momias de Guanajuato',
			'Weston State Hospital'
		)
	)

	UNION

	SELECT
	    name,
	    COALESCE("historic", "amenity", "landuse", "tourism", "railway") AS kind,
	    TRUE AS haunted,
	    ST_DumpPoints(way) AS __geometry__,
	    mz_id AS __id__

	FROM planet_osm_point

	WHERE name IS NOT NULL
        AND way && !bbox!

	AND (
		landuse = 'cemetery'
		OR amenity IN (
			'grave_yard',
			'crematorium',
                        'library'
		)
		OR historic IN (
			'tomb',
			'castle',
			'archaeological_site',
			'ruins'
		)
		OR railway = 'abandoned'
		OR name IN (
			'Museo de las Momias de Guanajuato',
			'Weston State Hospital'
		)
	)
) AS spooky
