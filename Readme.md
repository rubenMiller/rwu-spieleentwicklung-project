# Spieleentwicklung-Projekt

## erste Überlegungen

Grundidee:

Towerdefense, aber anders herum

Genauer:

Win-condition:
Burg/bergifried soll erobert werden

Start-Bedingungen:
Truppen/Einheiten, die der Spieler kontroliert
Wir brauchen:
Burg
bewegbare einheiten/Truppen

Wir müssen festlegen:
Truppen bewegen per Pathfinding oder per user interaction (etwa 'vormalen')

    -> Truppen sollen sich so bewegen, wie in bad north

## Verbesserungen Stand 05.06

auswählen linksclikc

bewegen rechts

Mörser ist zu stark:

Zu viel Stress, man kann nur eine Einheit auf einmal bewegen

Idee: Save spaces for dem Mörser
-> dann wird es evtl Schleich-Spiel, von Deckung zu Deckung

Wenn Mörser nie alleine ist, müssen wir nicht so viel Verändern

Ideen:

-drehende TÜrme -> deren Radius verändert sich
zB Sharpshooter oder Flammenturm

- dynamisches Feld
  Veränderung der Landschaft
  zB manche Felder sind nur einmal Belaufbar

--> Mischung aus neuem und Alten:

Mörser hat Radius und fängt erst an zu zielen, wenn in Radius.
Wenn wieder aus dem Radius, ist der Fortschritt für das Zielen fertig
