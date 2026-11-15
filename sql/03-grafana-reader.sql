BEGIN;

CREATE ROLE grafana_reader LOGIN;
GRANT CONNECT ON DATABASE cold_chain TO grafana_reader;
GRANT USAGE ON SCHEMA public TO grafana_reader;
GRANT SELECT ON TABLE public.temperature_excursions, public.batches TO grafana_reader;

COMMIT;