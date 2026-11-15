\# Cold Chain Monitor



Projekt edukacyjny do monitorowania temperatury powietrza w chłodniach firmy cateringowej.



\## Scenariusz



\- `cold-01` przechowuje partię `CAT-001`: 40 porcji kurczaka z ryżem i warzywami.

\- `cold-02` przechowuje partię `CAT-002`: 35 porcji makaronu z sosem pomidorowym.

\- W symulacji temperatura w `cold-02` rośnie z 4°C do 8°C, a potem wraca do 4°C.

\- Próg alertu w demo to 6°C.



\## Planowana architektura



1\. Symulator wysyła pomiary temperatury przez MQTT do brokera Mosquitto.

2\. n8n odbiera wiadomości, sprawdza ich format i zapisuje pomiary w InfluxDB.

3\. PostgreSQL przechowuje dane o partiach i pozwala powiązać przekroczenie

&#x20;  temperatury z partią znajdującą się wtedy w chłodni.

4\. Grafana pokazuje wykres temperatur, alert i raport przekroczeń według partii.

## Testy przepływu danych

| Próba | Wynik |
|---|---|
| `cold-02`, 4°C | Pomiar jest widoczny w InfluxDB w buckecie `telemetry`. |
| `cold-02`, 8°C | Pomiar jest widoczny w InfluxDB. PostgreSQL zapisał przekroczenie progu 6°C dla partii `CAT-002`. |
| `cold-02`, temperatura `awaria` | n8n odrzucił wiadomość w kroku walidacji z błędem „Temperatura musi być liczbą”. |