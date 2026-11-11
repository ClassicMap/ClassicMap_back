-- 새로 넣은 작품(슈트라우스·클레멘티·슈타미츠·쇤베르크·리게티·텔레만·퍼셀·스카를라티·몬테베르디·윤이상·홍난파·김동진)의
-- 빈 Apple Music·Spotify 링크를 채운다. 안 곡이 있는 작품은 그 작품이 다 든 앨범, 안 곡이 없는 작품은
-- 작품 트랙이 하나면 그 트랙·여러 트랙(오페라 전곡 등)이면 앨범. 한국 가곡은 원곡 녹음만 눈으로 골랐다.
-- 자료·규칙: seed_pipeline/curation/new-catalog-links-2026-11-12/(README, pick.py, korean.py, decisions.jsonl).
-- 비어 있을 때만 채우고 있는 링크는 건드리지 않는다. 두 번 돌려도 같다.
-- apple album 306, apple track 182, spotify album 299, spotify track 194

-- 34268 Il ritorno d'Ulisse in patria, SV 325 (apple: Monteverdi: Il ritorno d'Ulisse in patria)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-il-ritorno-d-ulisse-in-patria/1730883858' WHERE id = 34268 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34268 Il ritorno d'Ulisse in patria, SV 325 (spotify: Monteverdi: Il ritorno d'Ulisse in patria, SV 325)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1qJbsofqzQZmtY3hgDdM7h' WHERE id = 34268 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34269 Lamento d’Arianna, SV 22 (apple: Monteverdi: Lamento d'Arianna - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-lamento-d-arianna-ep/1783213808' WHERE id = 34269 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34270 Canzonette a tre voci, SV 1-21 (apple: Monteverdi: Canzonette à tre voci, Venice 1584)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-canzonette-a-tre-voci-venice-1584/1152954840' WHERE id = 34270 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34270 Canzonette a tre voci, SV 1-21 (spotify: Monteverdi: Canzonette a tre voci, Venice 1584)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20OeOZOqS8FY9YH1FONHVb' WHERE id = 34270 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34271 Madrigals, Book 1, SV 23–39 (apple: Monteverdi: Madrigals, Libri I & II)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-madrigals-libri-i-ii/1221343019' WHERE id = 34271 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34271 Madrigals, Book 1, SV 23–39 (spotify: Monteverdi: Madrigals, Libri I & II)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1SaBuhzV8Ss393GKnqSBVx' WHERE id = 34271 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34274 Quarto libro de madrigali, SV 75–93 (apple: Monteverdi: Il quarto libro de madrigali)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-il-quarto-libro-de-madrigali/1614426452' WHERE id = 34274 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34274 Quarto libro de madrigali, SV 75–93 (spotify: Monteverdi: Il quarto libro de madrigali)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5cnJD2lD3nHWw6TeLFychy' WHERE id = 34274 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34275 Quinto libro de madrigali, SV 94–106 (apple: Monteverdi: Quinto libro dei madrigali)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-quinto-libro-dei-madrigali/1452681365' WHERE id = 34275 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34275 Quinto libro de madrigali, SV 94–106 (spotify: Monteverdi: Il quinto libro de madrigali)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/35rE1uOKYtixyYAo1sYN3e' WHERE id = 34275 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34276 Sesto libro de madrigali, SV 107–116 (apple: Monteverdi: Il sesto libro de madrigali)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-il-sesto-libro-de-madrigali/1823823717' WHERE id = 34276 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34276 Sesto libro de madrigali, SV 107–116 (spotify: Monteverdi: Il sesto libro de madrigali, MDCXIV)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5cwCslVSlikfHyUvcCx4SV' WHERE id = 34276 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34277 Settimo Libro de Madrigali, SV 117–145 (spotify: Monteverdi: Settimo Libro de Madrigali)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0LbZlciK8dIP2Vl1FYEyd3' WHERE id = 34277 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34280 Scherzi Musicali (1607) SV 230-245 (apple: Monteverdi: Scherzi musicali, Venezia 1607)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-scherzi-musicali-venezia-1607/1383404272' WHERE id = 34280 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34280 Scherzi Musicali (1607) SV 230-245 (spotify: Monteverdi: Scherzi musicali, Venezia 1607)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Cpz8013fWaRJBz1SnY8RT' WHERE id = 34280 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34283 Missa da capella a sei voci "In illo tempore", SV 205 (apple: Monteverdi: Vespro della Beata Vergine)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-vespro-della-beata-vergine/1506210392' WHERE id = 34283 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34283 Missa da capella a sei voci "In illo tempore", SV 205 (spotify: Monteverdi: Vespro della Beata Vergine)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3xiAcrBpnAht7rUL7dpyYM' WHERE id = 34283 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34286 Adoramus te, Christe, SV 289 (apple: Monteverdi: Selva morale e spirituale)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/adoramus-te-sv-289/1114719848?i=1114719913' WHERE id = 34286 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34286 Adoramus te, Christe, SV 289 (spotify: Monteverdi: Adoramus te Christe, SV 289)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7B4D5iD3PTd4Y5poJvw53B' WHERE id = 34286 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34287 Cantate domino canticum novum a 6, SV 293 (apple: Splendours of the Gonzaga. Sacred Music from Wert to Monteverdi)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/cantate-domino-sv-293/1683127003?i=1683128034' WHERE id = 34287 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34287 Cantate domino canticum novum a 6, SV 293 (spotify: Monteverdi: Cantate Domino a 6, SV 293 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5Vt372O5jSl73ts7AT24gO' WHERE id = 34287 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34288 Christe, adoramus te, SV 294 (apple: Monteverdi: Frammenti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/christe-adoramus-sv-294/1700258858?i=1700259604' WHERE id = 34288 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34288 Christe, adoramus te, SV 294 (spotify: Monteverdi: Selva morale et l’œuvre religieuse pour Saint-Marc de Venise, vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2lPcwa7UDP7wTULpV3TYSy' WHERE id = 34288 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34289 Domine ne in furore tuo arguas me, SV 298 (apple: Monteverdi: Masses)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/domine-ne-in-furore-sv-298/1721160889?i=1721161175' WHERE id = 34289 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34289 Domine ne in furore tuo arguas me, SV 298 (spotify: Early Choral Music at Trinity College, Cambridge)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6Wh8uEqDkYc97kU2vttIu5' WHERE id = 34289 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34290 Ego flos campi, SV 301 (apple: Monteverdi: Testamento. Vespro della Madonna 1643)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ego-flos-campi-sv-301/1770304102?i=1770304104' WHERE id = 34290 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34290 Ego flos campi, SV 301 (spotify: Monteverdi: Testamento. Vespro della Madonna 1643)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1H70zJARkfpU7ix1tUsZY0' WHERE id = 34290 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34291 Venite sitientes ad aquas domini, SV 335 (apple: Claudio Monteverdi: Vespro di Natale / Christmas Vespers)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/venite-sitientes-ad-aquas-domini-sv-335/1637060794?i=1637061454' WHERE id = 34291 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34291 Venite sitientes ad aquas domini, SV 335 (spotify: Monteverdi: Frammenti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2m6Sud78yvul9oTp9w4hpI' WHERE id = 34291 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34292 Salve o regina, SV 326 (apple: Monteverdi: Messa a quattro voci da cappella, SV 190 - Salve Regina, SV 326 - Laetaniae della Beata Vergine, SV 204)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-salve-regina-sv-326/1495215016?i=1495215022' WHERE id = 34292 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34292 Salve o regina, SV 326 (spotify: Monteverdi: Messa a quattro voci da cappella, SV 190 - Salve Regina, SV 326 - Laetaniae della Beata Vergine, SV 204)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6MVRQLyNUHmXS0IcC0mXf0' WHERE id = 34292 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34293 Ego dormio et cor meum vigilat, SV 300 (apple: Monteverdi: Sacred Music, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ego-dormio-a-2-sv-300/1727381309?i=1727382185' WHERE id = 34293 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34293 Ego dormio et cor meum vigilat, SV 300 (spotify: Michel Corboz Conducts Monteverdi)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5CyAhSp5Z8kOzaMjfnSIx1' WHERE id = 34293 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34294 O quam pulchra es amica mea, SV 317 (apple: Eternal Monteverdi)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/o-quam-pulchra-es-sv-317/1210887325?i=1210887406' WHERE id = 34294 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34294 O quam pulchra es amica mea, SV 317 (spotify: Monteverdi: Frammenti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4Yg1Sc5Uuk3ilkxTAYQ8OJ' WHERE id = 34294 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34295 Currite populi, psallite timpanis, SV 297 (apple: Monteverdi: Sacred Music, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/currite-populi-psallite-timpanis-a-1-sv-297/1727381309?i=1727382172' WHERE id = 34295 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34295 Currite populi, psallite timpanis, SV 297 (spotify: Monteverdi: Selva morale et l’œuvre religieuse pour Saint-Marc de Venise, vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0mhfX4VlqfzHXtb22VGom8' WHERE id = 34295 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34296 Salve Regina, SV 327 (voce sola) (apple: Eternal Monteverdi)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/salve-regina-sv-327/1210887325?i=1210887435' WHERE id = 34296 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34296 Salve Regina, SV 327 (voce sola) (spotify: Salomone Rossi Ebreo: A Jewish Composer in 17th Century Italy)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5ljF6An2hAF7wZMSHmklWE' WHERE id = 34296 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34297 Exulta filia Sion, SV 303 (apple: Monteverdi: Sacred Music, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/exulta-filia-sion-sv-303/1727376447?i=1727377525' WHERE id = 34297 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34297 Exulta filia Sion, SV 303 (spotify: Songs to Mary)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/596d3QOTQVUX6Im9XvsnCq' WHERE id = 34297 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34298 Sancta Maria succurre miseris, SV 328 (apple: Monteverdi: Vespro della Beata Vergine)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sancta-maria-succurre-miseris-sv-328/1692443640?i=1692444379' WHERE id = 34298 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34298 Sancta Maria succurre miseris, SV 328 (spotify: Venice Preserv'd)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/19ovV9zeLU7E5Zj8FW1WoD' WHERE id = 34298 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34299 Venite videte martirem, SV 336 (apple: Monteverdi: Varie Musiche Sacre)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/venite-videte-martirem-sv-336/592967708?i=592968091' WHERE id = 34299 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34299 Venite videte martirem, SV 336 (spotify: Monteverdi: Varie Musiche Sacre)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4Mc6i75LCyeO5iIfyXHJZ7' WHERE id = 34299 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34300 Quarto Scherzo delle ariose vaghezze, SV 316: "Ohimè ch'io cado, ohimè ch'inciampo" (apple: Monteverdi: Scherzi Musicali)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ohim%C3%A8-chio-cado-ohim%C3%A8-chinciampo-sv-316/207680404?i=207681244' WHERE id = 34300 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34300 Quarto Scherzo delle ariose vaghezze, SV 316: "Ohimè ch'io cado, ohimè ch'inciampo" (spotify: Monteverdi: Teatro d'amore)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0h2a2deU3sPSDWfeaBQnoV' WHERE id = 34300 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34301 La mia Turca che d'Amor non ha fè, SV 310 (apple: Claudio Monteverdi: Essential Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/la-mia-turca-che-damor-non-ha-f%C3%A8-sv-310/1384579100?i=1384579508' WHERE id = 34301 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34301 La mia Turca che d'Amor non ha fè, SV 310 (spotify: Impressions of Orient)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/03IOuDEgZD2xzqMApiJEn8' WHERE id = 34301 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34302 Sì dolce è'l tormento, SV 332 (apple: Monteverdi: Scherzi Musicali)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/si-dolce-%C3%A8-l-tormento-sv-332/207680404?i=207680843' WHERE id = 34302 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34302 Sì dolce è'l tormento, SV 332 (spotify: The Beauty Of Monteverdi)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0Aseyu8M9MdDVTErMwkVeA' WHERE id = 34302 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34303 Voglio di vita uscir, SV 337 (apple: Monteverdi: Lettera amorosa)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/voglio-di-vita-uscir-sv-337/1572104258?i=1572104268' WHERE id = 34303 AND composer_id = 5 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34303 Voglio di vita uscir, SV 337 (spotify: Monteverdi & India: Olympia's Lament)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/15IY0bIpAG14WUlnkN7bPp' WHERE id = 34303 AND composer_id = 5 AND (spotify_url IS NULL OR spotify_url = '');
-- 34148 The Indian Queen, Z. 630 (apple: Purcell Edition, Vol. 2: The Indian Queen, the Tempest, Dioclesian & Timon of Athens)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-edition-vol-2-the-indian-queen-the-tempest-dioclesian-timon-of-athens/339589203' WHERE id = 34148 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34148 The Indian Queen, Z. 630 (spotify: Purcell: Edition Vol. 2. The Indian Queen, The Tempest, Dioclesian & Timon of Athens)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6CllzOEVuKyZEfP8p92Tzb' WHERE id = 34148 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34149 Timon of Athens (apple: Purcell Edition, Vol. 2: The Indian Queen, the Tempest, Dioclesian & Timon of Athens)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-edition-vol-2-the-indian-queen-the-tempest-dioclesian-timon-of-athens/339589203' WHERE id = 34149 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34149 Timon of Athens (spotify: Purcell: Edition Vol. 2. The Indian Queen, The Tempest, Dioclesian & Timon of Athens)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6CllzOEVuKyZEfP8p92Tzb' WHERE id = 34149 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34150 Amphitryon, Z. 572 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34150 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34150 Amphitryon, Z. 572 (spotify: Purcell: Music for the London Theater)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4XGCUQ5KEIVbsEtWvyqyil' WHERE id = 34150 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34151 Distressed Innocence, Z. 577 (apple: Purcell, H.: Distress'D Innocence - the Virtuous Wife - Sonata a 3 - Nos. 1, 3, 6, 8 - Sonata a 4 No. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-h-distress-d-innocence-the-virtuous-wife-sonata-a-3-nos-1-3-6-8-sonata-a-4-no-6/557447831' WHERE id = 34151 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34151 Distressed Innocence, Z. 577 (spotify: Purcell: Complete Theatre Ayres)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3XhcHEV86HViHspNDRAg2e' WHERE id = 34151 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34152 The Gordion Knot Unty’d, Z. 597 (apple: Purcell: Theatre Music, Vol. 1 - Amphitryon, Sir Barnaby Whigg, The Gordian Knot Unty'd)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music-vol-1-amphitryon-sir-barnaby-whigg-the-gordian-knot-unty-d/275291188' WHERE id = 34152 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34152 The Gordion Knot Unty’d, Z. 597 (spotify: Purcell: Theatre Music, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6CVObIkeDKYEI4z3IFOrKF' WHERE id = 34152 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34153 The Libertine Destroyed, Z. 600 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34153 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34154 Oedipus, King of Thebes, Z. 583 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34154 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34156 The Married Beau, Z. 603 "The Curious Impertinent" (apple: Purcell: Complete Theatre Ayres)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-complete-theatre-ayres/1698152285' WHERE id = 34156 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34156 The Married Beau, Z. 603 "The Curious Impertinent" (spotify: Purcell: Complete Theatre Ayres)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3XhcHEV86HViHspNDRAg2e' WHERE id = 34156 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34157 The Virtuous Wife, Z. 611 (apple: Purcell, H.: Distress'D Innocence - the Virtuous Wife - Sonata a 3 - Nos. 1, 3, 6, 8 - Sonata a 4 No. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-h-distress-d-innocence-the-virtuous-wife-sonata-a-3-nos-1-3-6-8-sonata-a-4-no-6/557447831' WHERE id = 34157 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34157 The Virtuous Wife, Z. 611 (spotify: Lost Is My Quiet)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2p5O7Q6U8HPCGgrmjOHiRi' WHERE id = 34157 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34158 Bonduca, or the British Heroine, Z. 574 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34158 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34158 Bonduca, or the British Heroine, Z. 574 (spotify: Henry Purcell: Love's Madness)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2ffJiRGKGDnhxPZwuITLpk' WHERE id = 34158 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34159 Pausanias, the Betrayer of his Country, Z. 585 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34159 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34159 Pausanias, the Betrayer of his Country, Z. 585 (spotify: Purcell / Locke / Blow / Gibbons - Wigmore Hall Live)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/641SlMHcC0rrUGlq8gIK14' WHERE id = 34159 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34160 The Comical History of Don Quixote, Z. 578 (apple: Purcell: Theatre Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-theatre-music/1452696368' WHERE id = 34160 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34160 The Comical History of Don Quixote, Z. 578 (spotify: Music of Henry Purcell)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/24OuKMAZDYAwLZHDlXh27T' WHERE id = 34160 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34161 Welcome Song - From Those Serene and Rapturous Joys, Z. 326 (apple: Purcell: Royal Odes)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-royal-odes/1612255051' WHERE id = 34161 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34161 Welcome Song - From Those Serene and Rapturous Joys, Z. 326 (spotify: Purcell: Royal Odes)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3y1uNHhJTlQQx4OSKalAWe' WHERE id = 34161 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34162 Ode, Z 343: "Why, why are all the Muses mute?" (apple: Purcell: Odes, Vol. 8 – Come Ye Sons of Art)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-odes-vol-8-come-ye-sons-of-art/570384478' WHERE id = 34162 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34162 Ode, Z 343: "Why, why are all the Muses mute?" (spotify: Purcell: Royal Odes)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3y1uNHhJTlQQx4OSKalAWe' WHERE id = 34162 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34163 Ye tuneful muses (Welcome Ode for Charles II), for soloists, chorus & instruments, Z. 344 (apple: Purcell: Odes, Vol. 4 – Ye Tuneful Muses)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-odes-vol-4-ye-tuneful-muses/614384430' WHERE id = 34163 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34163 Ye tuneful muses (Welcome Ode for Charles II), for soloists, chorus & instruments, Z. 344 (spotify: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2EcjuDXRt1v0MzlBGs5uU8' WHERE id = 34163 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34164 Sound the trumpet, beat the drum (Welcome Ode for James II), for 2 altos, tenors, basses, chorus, strings & continuo, Z. 335 (apple: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-odes-welcome-songs/1727386272' WHERE id = 34164 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34164 Sound the trumpet, beat the drum (Welcome Ode for James II), for 2 altos, tenors, basses, chorus, strings & continuo, Z. 335 (spotify: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2EcjuDXRt1v0MzlBGs5uU8' WHERE id = 34164 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34165 Now does the glorious day appear, Z. 332 (apple: Purcell: Odes for Queen Mary)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-odes-for-queen-mary/690693835' WHERE id = 34165 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34165 Now does the glorious day appear, Z. 332 (spotify: Purcell: Birthday Odes for Queen Mary)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7srYdGJS721lnewRvAiiJu' WHERE id = 34165 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34166 Of old when heroes thought it base, Z. 333 (apple: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-odes-welcome-songs/1727386272' WHERE id = 34166 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34166 Of old when heroes thought it base, Z. 333 (spotify: Beauteous Softness)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2PssvjRwd16F94A2YW4LRZ' WHERE id = 34166 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34167 Ode, Z 338 "Welcome, welcome, glorious morn" (apple: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-odes-welcome-songs/1727386272' WHERE id = 34167 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34168 Birthday Ode for Queen Mary "Love's Goddess Sure Was Blind", Z. 331 (apple: Choir of King's College Sings Purcell)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/choir-of-king-s-college-sings-purcell/1643674914' WHERE id = 34168 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34168 Birthday Ode for Queen Mary "Love's Goddess Sure Was Blind", Z. 331 (spotify: King's College Choir: Purcell)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5g0E4GpcRbgrnaxodUtbx9' WHERE id = 34168 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34169 Celebrate This Festival, Z. 321 (spotify: Bach, J.S.: Cantatas Nos. 102 & 151 / Purcell: Celebrate this Festival)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0prYDgugrDDvJqgU1wK2EZ' WHERE id = 34169 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34170 Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323 (apple: Purcell - Birthday Odes for Queen Mary)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-birthday-odes-for-queen-mary/691480145' WHERE id = 34170 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34170 Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323 (spotify: Purcell: Music for Queen Mary, Come ye Sons of Art)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/59IXibPF6cZcudHdvvskrK' WHERE id = 34170 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34171 Who can from joy refrain?, Z. 342 (apple: Purcell: Hail! Bright Cecilia & Who Can from Joy Refrain?)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-hail-bright-cecilia-who-can-from-joy-refrain/696585001' WHERE id = 34171 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34171 Who can from joy refrain?, Z. 342 (spotify: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2EcjuDXRt1v0MzlBGs5uU8' WHERE id = 34171 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34172 Welcome to all the pleasures, Z. 339 (apple: Music of Henry Purcell)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/music-of-henry-purcell/357650968' WHERE id = 34172 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34172 Welcome to all the pleasures, Z. 339 (spotify: Purcell: Dido & Aeneas; Ode for St. Cecilia's Day)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4KZGgr3hBx3AMp4uVAVXag' WHERE id = 34172 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34173 Ode, Z 334: "Raise raise the voice" (apple: Purcell: The Complete Odes & Welcome Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-odes-welcome-songs/1727386272' WHERE id = 34173 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34173 Ode, Z 334: "Raise raise the voice" (spotify: Purcell, H.: Ode for St. Cecilia's Day / Te Deum)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3dJr76v5gqSNEs7I4UYtOd' WHERE id = 34173 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34174 “Hail! Bright Cecilia”, Z. 328 (apple: Purcell: Funeral Sentences & Hail! Bright Cecilia)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-funeral-sentences-hail-bright-cecilia/880603916' WHERE id = 34174 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34174 “Hail! Bright Cecilia”, Z. 328 (spotify: Purcell: Hail! Bright Cecilia, Z. 328 "Ode to Saint Cecilia")
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3y0bfB7qo6OiWDC7RWAH5n' WHERE id = 34174 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34175 Hear My Prayer, O Lord, Z. 15 (apple: Purcell, Morley & Tomkins: English Royal Funeral Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/hear-my-prayer-o-lord-z-15/1571689086?i=1571689087' WHERE id = 34175 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34175 Hear My Prayer, O Lord, Z. 15 (spotify: Treasury of English Church Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2X63CcXAuUPFHs5SbgK9AQ' WHERE id = 34175 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34176 I was glad when they said unto me, Z. 19 (apple: Evening Prayer - Purcell Anthems and Sacred Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/i-was-glad-when-they-said-unto-me-o-lord-z-19/73669689?i=73669676' WHERE id = 34176 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34176 I was glad when they said unto me, Z. 19 (spotify: Purcell: Anthems & Sacred Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/30VQ9lNO9u4p6KwXqApzAi' WHERE id = 34176 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34177 My heart is inditing, Z. 30 (apple: Purcell: The Complete Anthems and Services, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-anthems-and-services-vol-4/583326347' WHERE id = 34177 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34177 My heart is inditing, Z. 30 (spotify: Purcell: Complete Sacred Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2b15daxg1q7hZLy8S6DFpM' WHERE id = 34177 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34178 My beloved spake, Z. 28 (apple: Purcell: The Complete Anthems and Services, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-anthems-and-services-vol-1/571826529' WHERE id = 34178 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34178 My beloved spake, Z. 28 (spotify: Purcell: Complete Sacred Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2b15daxg1q7hZLy8S6DFpM' WHERE id = 34178 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34179 O God, thou art my God, Z. 35 (apple: Purcell: Full Anthems & Organ Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/o-god-thou-art-my-god-z-35/19533791?i=19533678' WHERE id = 34179 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34179 O God, thou art my God, Z. 35 (spotify: Hear My Prayer - Hymns and Anthems)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0DPhn5XfDzjucDILbjU289' WHERE id = 34179 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34180 O sing unto the Lord a new song, Z.44 (apple: Purcell: The Complete Anthems and Services, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-anthems-and-services-vol-1/571826529' WHERE id = 34180 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34180 O sing unto the Lord a new song, Z.44 (spotify: Purcell: Complete Sacred Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2b15daxg1q7hZLy8S6DFpM' WHERE id = 34180 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34181 Rejoice in the Lord Always, Z. 49 (apple: Music of Henry Purcell)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/rejoice-in-the-lord-alway-the-bell-anthem-z49/357650968?i=357653541' WHERE id = 34181 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34181 Rejoice in the Lord Always, Z. 49 (spotify: Choir of King's College Sings Purcell)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0whWjHqzxq0RixxKjzYdA6' WHERE id = 34181 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34182 Remember not, Lord, our offences, Z. 50 (apple: Purcell 50)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/remember-not-lord-our-offences-z-50/1218806180?i=1218806676' WHERE id = 34182 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34182 Remember not, Lord, our offences, Z. 50 (spotify: Purcell: Anthems & Sacred Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7cjWQ2U6tNaRBogYKUrgSm' WHERE id = 34182 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34183 They that go down to the sea in ships, Z. 57 (apple: Purcell: Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/they-that-go-down-to-the-sea-in-ships-z-57/1452176716?i=1452177891' WHERE id = 34183 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34183 They that go down to the sea in ships, Z. 57 (spotify: Purcell: Music for the Chapel Royal)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2JS90jVjFsgI0a58D0BJyT' WHERE id = 34183 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34184 Thy word is a lantern unto my feet, Z. 61 (apple: Purcell: The Complete Anthems and Services, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/thy-word-is-a-lantern-unto-my-feet-z-61/583322717?i=583322723' WHERE id = 34184 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34184 Thy word is a lantern unto my feet, Z. 61 (spotify: Purcell: Complete Sacred Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5ShU7khRIaLIqVBERq6Tj4' WHERE id = 34184 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34185 Jehova, quam multi sunt hostes mei, Z. 135 (apple: Purcell: Full Anthems & Organ Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/jehova-quam-multi-sunt-hostes-mei-z-135/19533791?i=19533654' WHERE id = 34185 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34185 Jehova, quam multi sunt hostes mei, Z. 135 (spotify: Purcell: Sacred Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4jyeEzw8LcWcUwuDMNzAiT' WHERE id = 34185 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34186 Complete Service in B-flat, Z. 230 (apple: Purcell: Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-choral-works/1452176716' WHERE id = 34186 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34187 Magnificat and Nunc dimittis in G minor, Z231 (apple: Purcell: Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-choral-works/1452176716' WHERE id = 34187 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34187 Magnificat and Nunc dimittis in G minor, Z231 (spotify: The Feast of St Edward at Westminster Abbey)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2qBtNm9ouVq7O92wepZDZK' WHERE id = 34187 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34188 Te Deum and Jubilate Deo, for St. Cecilia's Day, Z. 232 (apple: Purcell: Sacred Music & Funeral Sentences for Queen Mary)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-sacred-music-funeral-sentences-for-queen-mary/720804296' WHERE id = 34188 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34188 Te Deum and Jubilate Deo, for St. Cecilia's Day, Z. 232 (spotify: Purcell: Music for Pleasure and Devotion)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/64ecRiXDyS7S9JiyOizYz1' WHERE id = 34188 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34189 An Evening Hymn, Z. 193 "Now that the sun hath veiled his light" (apple: Purcell: O Solitude, and other songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/an-evening-hymn-z-193/1452209860?i=1452210206' WHERE id = 34189 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34189 An Evening Hymn, Z. 193 "Now that the sun hath veiled his light" (spotify: Purcell: Anthems & Sacred Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0TCl2AypyjBCH22xvIfjjU' WHERE id = 34189 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34190 Lord, what is Man?, Z. 192 (apple: Purcell: Miscellany)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/lord-what-is-man-lost-man-z-192/1761628942?i=1761629067' WHERE id = 34190 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34190 Lord, what is Man?, Z. 192 (spotify: Purcell: Divine Hymns)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2sVDfaPXBeqLClpEwe8PCt' WHERE id = 34190 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34191 The Blessed Virgin's Expostulation (apple: Purcell: The Cares of Lovers)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/tell-me-some-pitying-angel-the-blessed-virgins/1561292466?i=1561292481' WHERE id = 34191 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34191 The Blessed Virgin's Expostulation (spotify: Henry Purcell: Love's Madness)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6msCqFTA35I0civLtTYWQZ' WHERE id = 34191 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34192 Mad Bess of Bedlam, Z. 370 "From Silent Shades and the Elysian Groves" (apple: Purcell: Royal Welcome Songs for King Charles II, Volume II)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/from-silent-shades-and-the-elysian-groves-z-370/1470231989?i=1470232223' WHERE id = 34192 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34192 Mad Bess of Bedlam, Z. 370 "From Silent Shades and the Elysian Groves" (spotify: Purcell: Songs and Airs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5PvQvxkbHqmPsyqCOG18a5' WHERE id = 34192 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34193 O Solitude, Z. 406 (apple: Purcell: O Solitude, and other songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/o-solitude-my-sweetest-choice-z-406/1452209860?i=1452210078' WHERE id = 34193 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34193 O Solitude, Z. 406 (spotify: Purcell: O Solitude (Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4bDNC7VXMAkxqqnEQkZX6W' WHERE id = 34193 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34194 If Music Be the Food of Love, Z. 379 (apple: Purcell: The Cares of Lovers)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/if-music-be-the-food-of-love-z-379c/1561292466?i=1561292475' WHERE id = 34194 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34194 If Music Be the Food of Love, Z. 379 (spotify: If music be the food of love, Z. 379)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3YsGEM6hvmfKR4I5ZqIlKX' WHERE id = 34194 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34195 The Queen's Epicedium, Z. 383 "Incassum Lesbia, incassum rogas" (apple: Purcell: Full Anthems & Organ Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/music-on-the-death-of-queen-mary-incassum-lesbia/19533791?i=19533771' WHERE id = 34195 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34195 The Queen's Epicedium, Z. 383 "Incassum Lesbia, incassum rogas" (spotify: Purcell: Songs and Airs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1m1jN3Fgi0Jwk8NW3NA8pb' WHERE id = 34195 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34196 Chacony in G minor for 2 violins, viola and continuo, Z. 730 (apple: Purcell: Complete Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/chacony-for-two-violins-viola-and-basso-continuo-z-730/700318897?i=700319538' WHERE id = 34196 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34196 Chacony in G minor for 2 violins, viola and continuo, Z. 730 (spotify: Purcell Edition Volume 4 : Instrumental Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/59wfZ7ioPC6NEPK4XcEpta' WHERE id = 34196 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34197 Fantasia, 3 parts on a Ground for three recorders, Z. 731 (apple: Purcell: Complete Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/fantasia-three-parts-on-a-ground-for-three/700318897?i=700321602' WHERE id = 34197 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34197 Fantasia, 3 parts on a Ground for three recorders, Z. 731 (spotify: Purcell: Songs & Dances)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5i0BVXQhBB4HsFvMUsv3o1' WHERE id = 34197 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34198 Fantazias and In Nomines, Z. 732–747 (apple: Purcell: The Complete Fantazias)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-the-complete-fantazias/1620634795' WHERE id = 34198 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34198 Fantazias and In Nomines, Z. 732–747 (spotify: Purcell: The Complete Fantazias)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4YgdwYtTfLd5xt3JT0Gf3r' WHERE id = 34198 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34199 Sonata for violin and basso continuo in G minor, Z. 780 (apple: Purcell: Ten Sonatas in Four Parts, Z. 802 - 811; Harpsichord Suites Nos. 5 & 6; Trio Sonata in G Minor, Z. 780 (2023 Remastered Edition))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-ten-sonatas-in-four-parts-z-802-811-harpsichord-suites-nos-5-6-trio-sonata-in-g-minor-z-780-2023-remastered-edition/1711709903' WHERE id = 34199 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34199 Sonata for violin and basso continuo in G minor, Z. 780 (spotify: Purcell: Ten Sonatas on Four Parts Z. 802-811, Harpsichord Suites Nos. 5 & 6, Trio Sonata in G Minor, Z. 780 (2023 Remastered Edition))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1MReYEmCGvU354qVOtNZzI' WHERE id = 34199 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34200 Sonnata's of III Parts, Z. 790–801 (apple: Purcell: Complete Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-complete-chamber-music/700318897' WHERE id = 34200 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34200 Sonnata's of III Parts, Z. 790–801 (spotify: Purcell: Twelve Sonatas in Three Parts)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1agDKz7OUdqwPdKgo74ZIt' WHERE id = 34200 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34201 Ten Sonata's in Four Parts, Z. 802–811 (apple: Purcell: Ten Sonatas in Four Parts)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-ten-sonatas-in-four-parts/1535771126' WHERE id = 34201 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34201 Ten Sonata's in Four Parts, Z. 802–811 (spotify: Purcell: Ten Sonatas in Four Parts)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2WfvkIRfhirYu8XB0cmI2x' WHERE id = 34201 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34202 Sonata for trumpet, strings, and basso continuo in D major, Z. 850 (apple: Purcell: Complete Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-complete-chamber-music/700318897' WHERE id = 34202 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34202 Sonata for trumpet, strings, and basso continuo in D major, Z. 850 (spotify: Purcell Edition Volume 4 : Instrumental Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6hAVXmbmiAWmgXh7KCPNV2' WHERE id = 34202 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34203 A Choice of Lessons for the Harpsichord or Spinnet, Z. 660–669 (apple: Purcell: Suites for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-suites-for-harpsichord/1371590948' WHERE id = 34203 AND composer_id = 8 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34203 A Choice of Lessons for the Harpsichord or Spinnet, Z. 660–669 (spotify: Purcell: A Choice Collection of Lessons for the Harpsichord or Spinnet)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3BrwzkhrXIc7Ycwd5bVdEn' WHERE id = 34203 AND composer_id = 8 AND (spotify_url IS NULL OR spotify_url = '');
-- 34204 Sonata in A minor, K 3, L 378: Presto (apple: Scarlatti: 15 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-a-minor-kk-3/692405644?i=692406051' WHERE id = 34204 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34204 Sonata in A minor, K 3, L 378: Presto (spotify: Scarlatti: Complete Keyboard Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6a4myeSL9NoWPVGJTfztS5' WHERE id = 34204 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34205 Sonata in G minor, K 8, L 488: Allegro (apple: Scarlatti to Scarlatti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-minor-k-8-f-524-allegro/1600553875?i=1600554142' WHERE id = 34205 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34205 Sonata in G minor, K 8, L 488: Allegro (spotify: Alessandro & Domenico Scarlatti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6pcujGK3zinsygIqAqnNTw' WHERE id = 34205 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34206 Sonata in C minor, K 11, L 352: Allegro (apple: The Art of Arturo Benedetti Michelangeli - Beethoven: Piano Sonata No. 32 / Galuppi: Sonata No. 5 / Scarlatti: Sonatas, K. 11, 159 & 322)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-c-minor-k-11/1421593425?i=1421593577' WHERE id = 34206 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34206 Sonata in C minor, K 11, L 352: Allegro (spotify: The Art of Arturo Benedetti Michelangeli - Beethoven: Piano Sonata No. 32 / Galuppi: Sonata No. 5 / Scarlatti: Sonatas, K 11, 159 & 322)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2ithNIxeVZyIe5NikykaNv' WHERE id = 34206 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34207 Sonata in G major, K 13, L 486: Presto (apple: Domenico Scarlatti: Piano Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-g-major-kk-13-presto/980224416?i=980224434' WHERE id = 34207 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34207 Sonata in G major, K 13, L 486: Presto (spotify: Scarlatti, D.: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2s7MjlILpLsl9dmpPqhwV5' WHERE id = 34207 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34208 Sonata in E major "Capriccio", K 20, L 375: Presto (apple: Domenico Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-e-major-k-20-presto/1452173615?i=1452173842' WHERE id = 34208 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34208 Sonata in E major "Capriccio", K 20, L 375: Presto (spotify: Scarlatti, D.: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4PtzdvWvd32Qa2WfnLgZUS' WHERE id = 34208 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34209 Sonata in A major, K 24, L 495: Presto (apple: Scarlatti: 15 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-a-major-kk-24/692405644?i=692405904' WHERE id = 34209 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34209 Sonata in A major, K 24, L 495: Presto (spotify: Scarlatti: 15 Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6oumt6Soefr2If6y0y2Jyj' WHERE id = 34209 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34210 Sonata in F-sharp minor, K 25, L 481: Allegro (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-f-sharp-minor-k-25/1471030153?i=1471030257' WHERE id = 34210 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34210 Sonata in F-sharp minor, K 25, L 481: Allegro (spotify: Scarlatti: 16 Sonatas, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1bSZ16NEXqg05Ze2UZOc1g' WHERE id = 34210 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34211 Sonata in D major, K 29, L 461: Presto (apple: Scarlatti to Scarlatti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-d-major-k-29-f-545-presto/1600553875?i=1600554490' WHERE id = 34211 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34211 Sonata in D major, K 29, L 461: Presto (spotify: D. Scarlatti : Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6ABmrhJ6uTZsv6xNlqZccy' WHERE id = 34211 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34212 Sonata in G minor "The Cat's Fugue", K 30, L 499: Moderato (apple: Domenico Scarlatti: The 556 Sonatas for Piano, Vol. 1: K. 1 - 60)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/piano-sonata-in-g-minor-k-30-fuga-del-gatto-moderato/1451732915?i=1451733314' WHERE id = 34212 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34212 Sonata in G minor "The Cat's Fugue", K 30, L 499: Moderato (spotify: Scarlatti: The Complete Keyboard Works, Vol. 1: Sonatas, Kk. 1 - 30 "Essercizi")
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1GMXzeDoXwmJlhpXxBEXSX' WHERE id = 34212 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34213 Sonata in D minor, K 32, L 423: Aria (apple: Scarlatti: Keyboard Sonata in D Minor, K. 32 - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-d-minor-k-32/1692920185?i=1692920196' WHERE id = 34213 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34213 Sonata in D minor, K 32, L 423: Aria (spotify: Scarlatti: Keyboard Sonata in D Minor, K. 32)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/43zfoYckReFhQkf9g3Plvn' WHERE id = 34213 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34214 Sonata in E major, K 46, L 25: Presto (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harpsichord-sonata-kk-46-in-e-major/257545841?i=257546112' WHERE id = 34214 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34214 Sonata in E major, K 46, L 25: Presto (spotify: Scarlatti: Complete Keyboard Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6oliv36pdC0Jpj7wYa3rAP' WHERE id = 34214 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34215 Sonata in A minor, K 54, L 241: Allegro (apple: Scarlatti: Sonata in A Minor, K. 54 - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-a-minor-k-54/1698746548?i=1698746561' WHERE id = 34215 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34215 Sonata in A minor, K 54, L 241: Allegro (spotify: Soler and Scarlatti in London)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1hu98zoGT8ENWWatEHMCqm' WHERE id = 34215 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34216 Sonata in F minor, K 69, L 382 (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-f-minor-k-69/1471030153?i=1471030633' WHERE id = 34216 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34216 Sonata in F minor, K 69, L 382 (spotify: Scarlatti: 42 Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5QApMD6vgnzYExjhX6t89S' WHERE id = 34216 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34217 Sonata in B minor, K 87, L 33 (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harpsichord-sonata-kk-87-in-b-minor/257545841?i=257546062' WHERE id = 34217 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34217 Sonata in B minor, K 87, L 33 (spotify: Scarlatti: Sonata in B Minor, K. 87)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7EHKWtRITTeEj6yk6GgiUy' WHERE id = 34217 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34218 Sonata in D major, K 96, L 465: Allegrissimo (apple: Scarlatti: 12 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/d-major-k-96-allegro/373940433?i=373940497' WHERE id = 34218 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34218 Sonata in D major, K 96, L 465: Allegrissimo (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4OxguKF52XMYv46ojieWcK' WHERE id = 34218 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34219 Sonata in A major, K 113, L 345: Allegro (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-a-major-k-113/1471030153?i=1471030260' WHERE id = 34219 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34219 Sonata in A major, K 113, L 345: Allegro (spotify: Scarlatti: 52 Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5fMBAwc6SJESd2TMYQxSPa' WHERE id = 34219 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34220 Sonata in D major, K 119, L 415 (apple: Domenico Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-d-major-kk-119-allegro/1452173615?i=1452174239' WHERE id = 34220 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34220 Sonata in D major, K 119, L 415 (spotify: Scarlatti: Keyboard Sonata in D Major, K. 119)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/663CMnCYeucQ5b5DUQ5j9a' WHERE id = 34220 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34221 Sonata in G major, K 125, L 487: Vivo (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-major-k-125/1471030153?i=1471030434' WHERE id = 34221 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34221 Sonata in G major, K 125, L 487: Vivo (spotify: Domenico Scarlatti “Sonata in G Major, K 125” - Stefano Bigoni, piano)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/417a8VaJRpI9A2v05kZ90o' WHERE id = 34221 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34222 Sonata in C major, K 132, L 457: Cantabile (apple: Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-c-major-kk-132/324842861?i=324842872' WHERE id = 34222 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34222 Sonata in C major, K 132, L 457: Cantabile (spotify: Scarlatti: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1JsAPEieSejxNAZNIfUqur' WHERE id = 34222 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34223 Sonata in E major, K 135, L 224: Allegro (apple: Domenico Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-e-major-k-135-allegro/1452173615?i=1452174074' WHERE id = 34223 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34223 Sonata in E major, K 135, L 224: Allegro (spotify: Scarlatti: The Complete Keyboard Works, Vol. 7: Sonatas, Kk. 131 - 150)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4W6bHaQrDddR4tD5ggoLdV' WHERE id = 34223 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34224 Sonata in G major, K 146, L 349 (apple: Scarlatti: 16 Sonatas, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-g-major-kk-146/693780463?i=693780950' WHERE id = 34224 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34224 Sonata in G major, K 146, L 349 (spotify: Domenico Scarlatti “Sonata in G Major, K 146” - Stefano Bigoni, piano)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3wepaCKvobRYVS8YRjFKg3' WHERE id = 34224 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34225 Sonata in E major, K 162, L 21: Andante - Allegro (apple: Scarlatti: 12 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/e-major-k-162-andante/373940433?i=373940450' WHERE id = 34225 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34225 Sonata in E major, K 162, L 21: Andante - Allegro (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1qdSYk8iVZkc8KeB5EHE6T' WHERE id = 34225 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34226 Sonata in A minor, K 175, L 429: Allegro (apple: Scarlatti: Keyboard Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-a-minor-k-175/1452511623?i=1452511632' WHERE id = 34226 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34226 Sonata in A minor, K 175, L 429: Allegro (spotify: Scarlatti & Cage Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1YAa3Pds63D6OAZ7dHIqe7' WHERE id = 34226 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34227 Sonata in G major, K 180, L 272: Allegro vivo (apple: Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-g-major-kk-180/1436244673?i=1436244688' WHERE id = 34227 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34227 Sonata in G major, K 180, L 272: Allegro vivo (spotify: Scarlatti: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4SLf90WrIQDb6n5tCISZvm' WHERE id = 34227 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34228 Sonata in B minor, K 197, L 147: Andante (apple: Horowitz: The Celebrated Scarlatti Recordings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-b-minor-k-197-l-147-andante/403897538?i=403897550' WHERE id = 34228 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34228 Sonata in B minor, K 197, L 147: Andante (spotify: Scarlatti: The Complete Keyboard Works, Vol. 10: Sonatas, Kk. 191 - 210)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5seeXiDHzuH26bqC2AJDuz' WHERE id = 34228 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34229 Sonata in E minor, K 198, L 22: Allegro (apple: Horowitz: The Celebrated Scarlatti Recordings (Expanded Edition))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-e-minor-k-198-l-22/158956381?i=158956655' WHERE id = 34229 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34229 Sonata in E minor, K 198, L 22: Allegro (spotify: Scarlatti: Complete Keyboard Sonatas, Vol. 24)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6slUho7KSGpHDjRGO9BaHY' WHERE id = 34229 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34230 Sonata in G major, K 201, L 129: Vivo (apple: Horowitz: The Celebrated Scarlatti Recordings (Expanded Edition))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-major-k-201-l-129/158956381?i=158957222' WHERE id = 34230 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34230 Sonata in G major, K 201, L 129: Vivo (spotify: Scarlatti: The Complete Keyboard Works, Vol. 10: Sonatas, Kk. 191 - 210)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4V8YXZiSVsLWWGVzCyYs7y' WHERE id = 34230 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34231 Sonata in A major, K 208, L 238: Adagio e cantabile (apple: Scarlatti: Piano Works, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-a-major-kk-208/1761628919?i=1761628934' WHERE id = 34231 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34231 Sonata in A major, K 208, L 238: Adagio e cantabile (spotify: D. Scarlatti: Keyboard Sonata in A Major, Kk. 208)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/73HLJRUAirUVq8vSYjk0lt' WHERE id = 34231 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34232 Sonata in A major, K 209, L 428: Allegro (apple: D. Scarlatti: Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-a-major-kk-209/6782131942?i=6782131959' WHERE id = 34232 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34232 Sonata in A major, K 209, L 428: Allegro (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/73VCj0caLrY9Ed2ssGeFJW' WHERE id = 34232 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34233 Sonata in D minor, K 213, L 108: Andante (apple: Scarlatti: Keyboard Sonata in D Minor, K. 213 - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-d-minor-k-213/1716309703?i=1716309980' WHERE id = 34233 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34233 Sonata in D minor, K 213, L 108: Andante (spotify: Scarlatti: Keyboard Sonata in D Minor, K. 213)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7teOZuEcRQV95NOZaFvhTI' WHERE id = 34233 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34234 Sonata in E major, K 216, L 273: Allegro (apple: Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-e-major-kk-216/1436244673?i=1436244682' WHERE id = 34234 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34234 Sonata in E major, K 216, L 273: Allegro (spotify: Scarlatti: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2rpMnp9St45cXq0isjojpv' WHERE id = 34234 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34235 Sonata in F minor, K 239, L 281: Allegro (apple: Ten Hundred Devils: Keyboard Sonatas by Domenico Scarlatti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-f-minor-kk-239/1251508222?i=1251508391' WHERE id = 34235 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34235 Sonata in F minor, K 239, L 281: Allegro (spotify: Scarlatti Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3rZvHH3oSP8gJfargqirsz' WHERE id = 34235 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34236 Sonata in G major, K. 260, L 124: Allegro (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-major-k-260/1471030153?i=1471030410' WHERE id = 34236 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34236 Sonata in G major, K. 260, L 124: Allegro (spotify: Scarlatti: The Complete Keyboard Works, Vol. 13: Sonatas, Kk. 252 - 271)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3NI18qRGVXV2JjTzE0cJ0t' WHERE id = 34236 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34237 Sonata in E minor, K 263, L 321: Andante (apple: Sçarlatti 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonate-en-mi-mineur-k-263-andante/589305632?i=589305643' WHERE id = 34237 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34237 Sonata in E minor, K 263, L 321: Andante (spotify: Scarlatti: The Complete Keyboard Works, Vol. 13: Sonatas, Kk. 252 - 271)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6d3YRsHkedu5jlpw0KI4eQ' WHERE id = 34237 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34238 Sonata in D major, K 278, L S15: Con velocità (apple: Domenico Scarlatti: Piano Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-d-major-kk-278-con-velocit%C3%A0/980224416?i=980225366' WHERE id = 34238 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34238 Sonata in D major, K 278, L S15: Con velocità (spotify: Scarlatti: The Complete Keyboard Works, Vol. 14: Sonatas, Kk. 272 - 291)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/74Fk7nMIa7nUFiVUqwtTgD' WHERE id = 34238 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34239 Sonata in A major, K 322, L 483: Allegro (apple: Domenico Scarlatti, Sonata in a Major, K322, L.483 - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/domenico-scarlatti-sonata-in-a-major-k322-l-483/1358139835?i=1358140365' WHERE id = 34239 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34239 Sonata in A major, K 322, L 483: Allegro (spotify: Domenico Scarlatti: Sonata in A Major, K 322)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/31i0k74W6cGwQ8ZRp2P1ll' WHERE id = 34239 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34240 Sonata in A major, K 323, L 95: Allegro (apple: Scarlatti, D.: Complete Keyboard Sonatas, Vol. 12)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-a-major-k-323-l-95-p-411/348046953?i=348047066' WHERE id = 34240 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34240 Sonata in A major, K 323, L 95: Allegro (spotify: Scarlatti: Sonatas for Harpsichord, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3vZxWTgyr8qyA2fRt5XXDl' WHERE id = 34240 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34241 Sonata in F minor, K 386, L 171: Presto (apple: Scarlatti: 16 Sonatas, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-f-minor-kk-386/693780463?i=693780954' WHERE id = 34241 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34241 Sonata in F minor, K 386, L 171: Presto (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4SsAoXKeAvmgRx5UdmfWLm' WHERE id = 34241 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34242 Sonata in E minor, K 394, L 275: Allegro (apple: Scarlatti: 12 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/e-minor-k-394-allegro/373940433?i=373940500' WHERE id = 34242 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34242 Sonata in E minor, K 394, L 275: Allegro (spotify: Encores: Chopin, Scarlatti, Scriabin, Debussy…)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/63pml8R6q4GgCD41EW3ExN' WHERE id = 34242 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34243 Sonata in C major, K 420, L S2: Allegro (apple: D. Scarlatti: Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-c-major-kk-420/6782131942?i=6782131951' WHERE id = 34243 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34243 Sonata in C major, K 420, L S2: Allegro (spotify: D. Scarlatti: Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0nKTPAbTFVKIbnr0q5YDmV' WHERE id = 34243 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34244 Sonata in G major, K 425, L 333: Allegro molto (apple: Scarlatti: 18 Keyboard Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-g-major-kk-425/691417529?i=691417544' WHERE id = 34244 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34244 Sonata in G major, K 425, L 333: Allegro molto (spotify: Scarlatti: 18 Keyboard Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1PbplgxMQVInR0NqDbEycC' WHERE id = 34244 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34245 Sonata in G major, K 427, L 286: Presto, quanto sia possibile (apple: Scarlatti: Complete Keyboard Sonatas, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-major-k-427-l-286-p-464/19603002?i=19602962' WHERE id = 34245 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34245 Sonata in G major, K 427, L 286: Presto, quanto sia possibile (spotify: Scarlatti: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7qY941ttkmlkkdBst0poeO' WHERE id = 34245 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34246 Sonata in D major, K. 430, L 463: Non presto ma a tempo di ballo (apple: Liaisons, Vol. 1: Piano Works by Scarlatti & Bartók)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-d-major-k-430-l-463-non-presto/1669531440?i=1669531446' WHERE id = 34246 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34246 Sonata in D major, K. 430, L 463: Non presto ma a tempo di ballo (spotify: D. Scarlatti : Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7rtHi9wgpYS4h25tUfhvQ5' WHERE id = 34246 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34247 Sonata in D major, K 435, L 361 (apple: Domenico Scarlatti: Piano Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-d-major-kk-435-allegro/980224416?i=980225346' WHERE id = 34247 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34247 Sonata in D major, K 435, L 361 (spotify: Scarlatti: The Complete Keyboard Works, Vol. 22: Sonatas, Kk. 433 - 453)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/78rTcOGpahvKrP6rUJpoFY' WHERE id = 34247 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34248 Sonata in G minor, K 450, L 338: Allegrissimo (apple: Scarlatti: Keyboard Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-minor-k-450/1452511623?i=1452511805' WHERE id = 34248 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34248 Sonata in G minor, K 450, L 338: Allegrissimo (spotify: Scarlatti: The Complete Keyboard Works, Vol. 22: Sonatas, Kk. 433 - 453)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3Yc1JPfd8Pvh3lcOxxEzCR' WHERE id = 34248 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34249 Sonata in G major, K 455, L 209: Allegro (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-g-k-455/1452551819?i=1452552188' WHERE id = 34249 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34249 Sonata in G major, K 455, L 209: Allegro (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3xuKZxAR89FyVjDwbFYDpN' WHERE id = 34249 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34250 Sonata in F minor, K 462, L 438: Andante (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-f-minor-k-462/1471030153?i=1471030583' WHERE id = 34250 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34250 Sonata in F minor, K 462, L 438: Andante (spotify: Scarlatti: Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0LreTlH56ngJ9aylhPMhua' WHERE id = 34250 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34251 Sonata in E-flat major, K 474, L 203: Andante cantabile (apple: Scarlatti: The Complete Keyboard Works, Vol. 24: Sonatas, Kk. 474 - 494)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-e-flat-major-kk-474/1492753330?i=1492753334' WHERE id = 34251 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34251 Sonata in E-flat major, K 474, L 203: Andante cantabile (spotify: Scarlatti: The Complete Keyboard Works, Vol. 24: Sonatas, Kk. 474 - 494)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/797QRHpBowo2T9thOp0OOf' WHERE id = 34251 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34252 Sonata in F minor, K 481, L 187: Andante cantabile (apple: Scarlatti: Ombre et lumière)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonate-en-fa-mineur-k-481-andante-e-cantabile/947408662?i=947408699' WHERE id = 34252 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34252 Sonata in F minor, K 481, L 187: Andante cantabile (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0bE2GLsxGswhoM05KYBLDN' WHERE id = 34252 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34253 Sonata in D major, K 490, L 206 (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harpsichord-sonata-kk-490-in-d-major/257545841?i=257546241' WHERE id = 34253 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34253 Sonata in D major, K 490, L 206 (spotify: Scarlatti: Keyboard Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6HPgQZgthWRGF84wfDhrl5' WHERE id = 34253 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34254 Sonata in D major, K 491, L 164: Allegro (apple: Domenico Scarlatti: The 556 Sonatas for Piano, Vol. 9: K. 491 - 555)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/piano-sonata-in-d-major-k-491-allegro/1453010320?i=1453010321' WHERE id = 34254 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34254 Sonata in D major, K 491, L 164: Allegro (spotify: Scarlatti: Sonata in D Major, K. 491)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3ia6rrhjx14dZ0ipQp8J4N' WHERE id = 34254 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34255 Sonata in D major, K 492, L 14: Presto (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harpsichord-sonata-kk-492-in-d-major/257545841?i=257546375' WHERE id = 34255 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34255 Sonata in D major, K 492, L 14: Presto (spotify: Scarlatti: Piano Sonatas, Kk. 1, 9, 64, 87, 159, 239, 259, 268, 377, 380, 432 & 492)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5AVHsOCJcy7L33vnJ0INER' WHERE id = 34255 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34256 Sonata in C major, K 513, L S3: Moderato e Molto allegro - Presto (apple: Scarlatti: Sonatas for Harpsichord)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harpsichord-sonata-kk-513-in-c-major/257545841?i=257546558' WHERE id = 34256 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34256 Sonata in C major, K 513, L S3: Moderato e Molto allegro - Presto (spotify: Scarlatti, D.: Keyboard Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2QB3g129nscuvI67bvywdx' WHERE id = 34256 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34257 Sonata in F minor, K 519, L 475: Allegro assai (apple: D. Scarlatti: Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/keyboard-sonata-in-f-minor-kk-519/6782131942?i=6782131967' WHERE id = 34257 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34257 Sonata in F minor, K 519, L 475: Allegro assai (spotify: Scarlatti: 15 Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1cxMnyLJ2LBMp0k3cg7Rl7' WHERE id = 34257 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34258 Sonata in F major, K 525, L 188: Allegro (apple: Horowitz: The Celebrated Scarlatti Recordings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-f-major-k-525-l-188-allegro/403897538?i=403897567' WHERE id = 34258 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34258 Sonata in F major, K 525, L 188: Allegro (spotify: Scarlatti: 22 Sonates Pour Clavecin)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7wvkmJLtaMbCTPlgNIy1FW' WHERE id = 34258 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34259 Sonata in E major, K 531, L 430: Allegro (apple: Scarlatti: 52 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-e-major-k-531/1471030153?i=1471030157' WHERE id = 34259 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34259 Sonata in E major, K 531, L 430: Allegro (spotify: Domenico Scarlatti “Sonata in E Major, K 531" - Stefano Bigoni, piano)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7iYJeqz0ThbRb00H1xtw6C' WHERE id = 34259 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34260 Sonata in A minor, K 532, L 223: Allegro (apple: D. Scarlatti: Complete Keyboard Sonatas, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-a-minor-k-532-l-223-p-536/19641072?i=19641031' WHERE id = 34260 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34260 Sonata in A minor, K 532, L 223: Allegro (spotify: Scarlatti: 22 Sonates Pour Clavecin)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5rJ8wyjyISroqk27K539tr' WHERE id = 34260 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34261 Sonata in A major, K 533, L 395: Allegro assai (apple: Scarlatti: Complete Keyboard Sonatas, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-a-major-k-533-l-395-p-537/19603002?i=19602990' WHERE id = 34261 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34261 Sonata in A major, K 533, L 395: Allegro assai (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1HoXScnoSw4FCVm5Uk1cqo' WHERE id = 34261 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34262 Sonata in B-flat major, K 544, L 497: Cantabile (apple: Scarlatti: Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sonata-in-b-flat-major-kk-544/1452329301?i=1452330648' WHERE id = 34262 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34262 Sonata in B-flat major, K 544, L 497: Cantabile (spotify: Scarlatti: 33 Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6x2JfzWUOUB3UAoUJJ1KlP' WHERE id = 34262 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34263 Stabat Mater (apple: Domenico Scarlatti: Stabat Mater & Other Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/domenico-scarlatti-stabat-mater-other-works/1613630325' WHERE id = 34263 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34263 Stabat Mater (spotify: Scarlatti: Stabat Mater - Clément: O Maria, vernans rosa - Gesualdo: Ave dulcissima Maria - Cavalli: Salve Regina)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3QKjxfl59t4AnVke1M0PSX' WHERE id = 34263 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34264 Salve Regina in A major (apple: Domenico Scarlatti: Salve Regina (feat. Carlos Mena))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/domenico-scarlatti-salve-regina-feat-carlos-mena/509534739' WHERE id = 34264 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34264 Salve Regina in A major (spotify: Vivaldi, Scarlatti, Avison: Salve Regina, Stabat Mater, Concerti per Archi)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3ggjNfbKkIccQNJNTWfzv7' WHERE id = 34264 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34265 Missa breve, "La stella" (apple: Iste Confessor - The Sacred Music of Domenico Scarlatti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/iste-confessor-the-sacred-music-of-domenico-scarlatti/65741262' WHERE id = 34265 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34265 Missa breve, "La stella" (spotify: Iste Confessor - The Sacred Music of Domenico Scarlatti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1u0DsQ7HbKzFvpOfv1X5ur' WHERE id = 34265 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34266 Missa Quatuor vocum "de Madrid" (apple: Domenico Scarlatti: Stabat mater a dieci voci)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/domenico-scarlatti-stabat-mater-a-dieci-voci/1189094841' WHERE id = 34266 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34266 Missa Quatuor vocum "de Madrid" (spotify: Scarlatti: Stabat Mater - Missa Quatuor vocum (Madrid Mass))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3c5PkIgy45pni5fYbNWw17' WHERE id = 34266 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34267 Te Deum (apple: Iste Confessor - The Sacred Music of Domenico Scarlatti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/te-deum/65741262?i=65740211' WHERE id = 34267 AND composer_id = 9 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34267 Te Deum (spotify: Scarlatti: Te Deum, Stabat Mater, Magnificat & Laetatus sum)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4od3RynWb5N3mJwSaTnHzf' WHERE id = 34267 AND composer_id = 9 AND (spotify_url IS NULL OR spotify_url = '');
-- 34073 Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth" (apple: Telemann, G.P.: Overture (Suites) in C Major - E Minor - F Major)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-overture-suites-in-c-major-e-minor-f-major/451649887' WHERE id = 34073 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34073 Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth" (spotify: l'europe réunie)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0xm6lbNSTN9ahTX1dghpKQ' WHERE id = 34073 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34074 Ouverture-Suite, TWV 55:G4, ' Les nations anciens et modernes' (apple: Telemann: Les Nations - Ouvertures & Oboe Concerti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-les-nations-ouvertures-oboe-concerti/978405058' WHERE id = 34074 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34074 Ouverture-Suite, TWV 55:G4, ' Les nations anciens et modernes' (spotify: Telemann: Suite in A Minor, Concerto for Viola, Concerto for Recorder and Flute & Ouverture des Nations)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1HDfdSVMB3Q6JQAKxl0ixb' WHERE id = 34074 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34075 Ouverture in B-flat major, TWV 55:B5 "Völker-Ouvertüre" (apple: Telemann: Les Nations - Ouvertures & Oboe Concerti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-les-nations-ouvertures-oboe-concerti/978405058' WHERE id = 34075 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34075 Ouverture in B-flat major, TWV 55:B5 "Völker-Ouvertüre" (spotify: Telemann: Overtures and Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7zUyCHguMYiGfgv3yrq2VG' WHERE id = 34075 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34076 Overture in F major, "Alster Echo", TWV 55:F11 (apple: Telemann Edition, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-edition-vol-1/1175426594' WHERE id = 34076 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34076 Overture in F major, "Alster Echo", TWV 55:F11 (spotify: Telemann: Wassermusik)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1zM66NzHtxHHXyvry0mgpu' WHERE id = 34076 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34077 Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8 (apple: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/georg-philipp-telemann-viola-concertos-overtures-fantasias/1595870873' WHERE id = 34077 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34077 Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8 (spotify: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4WirZJJ4VxQKHFBj7kSYfc' WHERE id = 34077 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34078 Ouverture-Suite "La Bizarre", TWV 55:G2 (apple: Telemann: 6 Orchestral Suites)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-6-orchestral-suites/351611408' WHERE id = 34078 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34078 Ouverture-Suite "La Bizarre", TWV 55:G2 (spotify: Terpsichore: L'apothéose de la danse baroque)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1avhGEz9WS8adhfrBAiKyM' WHERE id = 34078 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34079 Ouverture-Suite in G minor “La Changeante”, TWV 55:g2 (apple: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/georg-philipp-telemann-viola-concertos-overtures-fantasias/1595870873' WHERE id = 34079 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34079 Ouverture-Suite in G minor “La Changeante”, TWV 55:g2 (spotify: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4WirZJJ4VxQKHFBj7kSYfc' WHERE id = 34079 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34080 Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne" (apple: Telemann: Overtures - Du angenehmer Weiberorden - Trauer-Music eines kunsterfahrenen)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-overtures-du-angenehmer-weiberorden-trauer-music-eines-kunsterfahrenen/361404999' WHERE id = 34080 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34080 Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne" (spotify: Telemann: Overtures - Du angenehmer Weiberorden - Trauer-Music eines kunsterfahrenen)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2hOuckGsPGeVxl0kKOAXBk' WHERE id = 34080 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34081 Ouverture-Suite, TWV 55:B11 "La Bourse" (apple: Totally Telemann (Music for Orchestra))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/totally-telemann-music-for-orchestra/965337919' WHERE id = 34081 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34081 Ouverture-Suite, TWV 55:B11 "La Bourse" (spotify: Totally Telemann (Music for Orchestra))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4q5Sfsj41EirK3yjeTw9qw' WHERE id = 34081 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34082 Ouverture-Suite, TWV 55:g4 (apple: Telemann: Concerto in D Major & Suiten)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-concerto-in-d-major-suiten/1669740754' WHERE id = 34082 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34082 Ouverture-Suite, TWV 55:g4 (spotify: Telemann: Concerto for 3 Trumpets in D Major; Tafelmusik, Pt. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7srtH48h3YwVA1Ogit8Aga' WHERE id = 34082 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34083 Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6 (apple: Telemann - Art Edition: Ouverture-Suites, TWV 55:A2 & TWV 55:D6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-art-edition-ouverture-suites-twv-55-a2-twv-55-d6/1845466558' WHERE id = 34083 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34083 Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6 (spotify: Telemann: Sinfonia Spirituosa; String Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2nJX3LIjdAbNIGR3qbQaBI' WHERE id = 34083 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34084 Grillen-Symphonie, TWV 50:1 (apple: Telemann, Platti, Vivaldi & Geminiani: Concerti all'arrabbiata)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-platti-vivaldi-geminiani-concerti-all-arrabbiata/1588389712' WHERE id = 34084 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34084 Grillen-Symphonie, TWV 50:1 (spotify: Telemann: Don Quixote and Other Suites & Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/51Do5nXsTvTJ6PJJOXGtyt' WHERE id = 34084 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34085 Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1 (apple: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-violin-concertos-overture-suite-fantasie/1823706569' WHERE id = 34085 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34085 Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1 (spotify: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4vNE1YXtVVgTPrABEY058y' WHERE id = 34085 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34086 Trumpet Concerto in D major, TWV 51:D7 (apple: Telemann, G.P.: Trumpet Music (Telemann for Trumpet))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-trumpet-music-telemann-for-trumpet/559889730' WHERE id = 34086 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34086 Trumpet Concerto in D major, TWV 51:D7 (spotify: Baroque Trumpet (The Art Of The), Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3Jq0zsqAYGBwdHgvSndvD1' WHERE id = 34086 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34087 Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8 (apple: Telemann, Förster, Haydn & Beer: Horn Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-forster-haydn-beer-horn-concertos/327922029' WHERE id = 34087 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34087 Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8 (spotify: Telemann: Complete Horn Concertos for Horns, Strings & Basso Continuo)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5zwNMgtRt2xoFkhLqBbB33' WHERE id = 34087 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34088 Concerto for Flute, Strings and Continuo in D, TWV 51:D2 (apple: Telemann, G.P.: Wind Concertos, Vol. 4 - Twv 51:A2, 51:D2, 51:E1, 52:A2, 53:B1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-wind-concertos-vol-4-twv-51-a2-51-d2-51-e1-52-a2-53-b1/367192516' WHERE id = 34088 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34088 Concerto for Flute, Strings and Continuo in D, TWV 51:D2 (spotify: Telemann: Flute Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4BxVf0HolGJ9gyifBbYGjb' WHERE id = 34088 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34089 Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1 (apple: Telemann, G.P.: Wind Concertos, Vol. 1 - Twv 43:G3, 51:D1, 51:E1, 52:D2, E1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-wind-concertos-vol-1-twv-43-g3-51-d1-51-e1-52-d2-e1/367095023' WHERE id = 34089 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34089 Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1 (spotify: Marcello, A.: Oboe Concerto in D Minor / Telemann, G.P.: Oboe Concerto in F Minor / Handel, G.F.: Oboe Concerto No. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0rp3Oeu4Lc33TGFwvh471w' WHERE id = 34089 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34090 Flute Concerto in B minor, TWV 51:h1 (apple: Telemann: Wind Concertos, Vol. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-wind-concertos-vol-6/475741028' WHERE id = 34090 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34090 Flute Concerto in B minor, TWV 51:h1 (spotify: Telemann: Wind Concertos, Vol. 6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1jHhkQbA40lGCKjtRHVBwv' WHERE id = 34090 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34091 Recorder Concerto in C major, TWV 51:C1 (apple: Telemann : Concertos & suite pour flûte et cordes)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-concertos-suite-pour-flute-et-cordes/1465073771' WHERE id = 34091 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34091 Recorder Concerto in C major, TWV 51:C1 (spotify: Telemann: The Complete Wind Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2fEvhm22Bu75TnflwNqxXd' WHERE id = 34091 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34092 Recorder Concerto in F major, TWV 51:F1 (apple: Telemann : Concertos & suite pour flûte et cordes)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-concertos-suite-pour-flute-et-cordes/1465073771' WHERE id = 34092 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34092 Recorder Concerto in F major, TWV 51:F1 (spotify: Telemann: Wind Concertos, Vol. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4efpMQ7UczvRA2YEMZNTWj' WHERE id = 34092 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34093 Oboe Concerto in C minor, TWV 51:c1 (apple: Telemann: Oboe Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-oboe-concertos/1452639029' WHERE id = 34093 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34094 Oboe Concerto in D minor, TWV 51:d1 (apple: Telemann: Oboe Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-oboe-concertos/1452639029' WHERE id = 34094 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34094 Oboe Concerto in D minor, TWV 51:d1 (spotify: Telemann: The Complete Wind Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2fEvhm22Bu75TnflwNqxXd' WHERE id = 34094 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34095 Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1 (apple: Telemann, G.P.: Wind Concertos, Vol. 4 - Twv 51:A2, 51:D2, 51:E1, 52:A2, 53:B1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-wind-concertos-vol-4-twv-51-a2-51-d2-51-e1-52-a2-53-b1/367192516' WHERE id = 34095 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34095 Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1 (spotify: Telemann, Vivaldi, Marcello: Oboe & Recorder Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1ztyF9CV0hcVzMv8q2Oyks' WHERE id = 34095 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34096 Oboe Concerto in F minor, TWV 51:f1 (apple: Telemann: Wind Concertos, Vol. 2 - Twv 51:F1, 51:G1, 52:C1, 52:D1, 53:D1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-wind-concertos-vol-2-twv-51-f1-51-g1-52-c1-52-d1-53-d1/343174211' WHERE id = 34096 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34096 Oboe Concerto in F minor, TWV 51:f1 (spotify: Baroque Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Z9GTf0uQit5gXi34Mvp2L' WHERE id = 34096 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34097 Concerto for Oboe D'Amore, Strings & Continuo in A major, TWV 51:A2 (apple: Telemann, G.P.: Wind Concertos, Vol. 4 - Twv 51:A2, 51:D2, 51:E1, 52:A2, 53:B1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-wind-concertos-vol-4-twv-51-a2-51-d2-51-e1-52-a2-53-b1/367192516' WHERE id = 34097 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34097 Concerto for Oboe D'Amore, Strings & Continuo in A major, TWV 51:A2 (spotify: Telemann, G.P.: Concertos, Twv 53:E1, Twv 51:A2 / Vivaldi, A.: Viola D'Amore Concerto, Rv 392 / Graupner, C.: Concerto, Gwv 333 (Il Gardellino))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2Z0TGhhAwEx99hFbO06blI' WHERE id = 34097 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34098 Concerto for Oboe d'amore in G major, TWV 51:G3 (apple: Telemann: Oboe Concerto in G Major, TWV 51:G3 (Remastered) - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-oboe-concerto-in-g-major-twv-51-g3-remastered-ep/1030388252' WHERE id = 34098 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34098 Concerto for Oboe d'amore in G major, TWV 51:G3 (spotify: Telemann: Oboe Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2C3zDa6rN4oJbIpt39ly1v' WHERE id = 34098 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34099 Concerto in A major, TWV 51:A4, "Die Relinge" (apple: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-violin-concertos-overture-suite-fantasie/1823706569' WHERE id = 34099 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34099 Concerto in A major, TWV 51:A4, "Die Relinge" (spotify: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4vNE1YXtVVgTPrABEY058y' WHERE id = 34099 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34100 Violin Concerto in A minor, TWV 51:a1 (apple: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-violin-concertos-overture-suite-fantasie/1823706569' WHERE id = 34100 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34100 Violin Concerto in A minor, TWV 51:a1 (spotify: Telemann: Violin Concertos. Overture. Suite. Fantasie)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4vNE1YXtVVgTPrABEY058y' WHERE id = 34100 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34101 Violin Concerto in F-sharp minor, TWV 51:fis1 (apple: Telemann: Complete Violin Concertos, Vol. 5)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-complete-violin-concertos-vol-5/577622286' WHERE id = 34101 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34102 Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1 (apple: Bach & Telemann: Effervescence concertante)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/bach-telemann-effervescence-concertante/1668830283' WHERE id = 34102 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34102 Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1 (spotify: Telemann: Double & Triple Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3PtMKhB3V1QLcQ2IWtgYVv' WHERE id = 34102 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34103 Concerto for Recorder and Viola da Gamba in A minor, TWV 52:a1 (apple: Telemann: Tutti Flauti!)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-tutti-flauti/341847699' WHERE id = 34103 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34103 Concerto for Recorder and Viola da Gamba in A minor, TWV 52:a1 (spotify: Telemann: Concerto In A minor; Duet In C; Trio Sonatas / Heberle: Recorder Concerto In G)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/637umMbvsi8QiJOOtC64s2' WHERE id = 34103 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34104 Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1 (apple: Telemann, G.P.: Double Concerto for Recorder and Bassoon, Twv 52:F1 - Viola Concerto, Twv 51:G9)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-double-concerto-for-recorder-and-bassoon-twv-52-f1-viola-concerto-twv-51-g9/397128033' WHERE id = 34104 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34104 Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1 (spotify: Telemann: Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/76qS9LjJHk22lC1S7TGoWj' WHERE id = 34104 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34105 Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2 (apple: Telemann: Concertos for Solo Recorder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-concertos-for-solo-recorder/1390014388' WHERE id = 34105 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34106 Concerto for Two Violas in G major, TWV 52:G3 (apple: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/georg-philipp-telemann-viola-concertos-overtures-fantasias/1595870873' WHERE id = 34106 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34106 Concerto for Two Violas in G major, TWV 52:G3 (spotify: Georg Philipp Telemann: Viola Concertos - Overtures - Fantasias)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4WirZJJ4VxQKHFBj7kSYfc' WHERE id = 34106 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34107 Double Concerto for 2 Horns in D major, TWV 52:D1 (apple: Telemann: Wind Concertos, Vol. 2 - Twv 51:F1, 51:G1, 52:C1, 52:D1, 53:D1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-wind-concertos-vol-2-twv-51-f1-51-g1-52-c1-52-d1-53-d1/343174211' WHERE id = 34107 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34107 Double Concerto for 2 Horns in D major, TWV 52:D1 (spotify: Telemann: Complete Horn Concertos for Horns, Strings & Basso Continuo)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5zwNMgtRt2xoFkhLqBbB33' WHERE id = 34107 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34108 Concerto for 2 Horns in E-flat major, TWV 52:Es1 (apple: Telemann: Wind Concertos, Vol. 5)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-wind-concertos-vol-5/412902054' WHERE id = 34108 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34108 Concerto for 2 Horns in E-flat major, TWV 52:Es1 (spotify: Telemann: Wind Concertos, Vol. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4efpMQ7UczvRA2YEMZNTWj' WHERE id = 34108 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34109 Concerto for 2 Chalumeaux in D minor, TWV 52:d1 (apple: Telemann: Wind Concertos, Vol. 7)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-wind-concertos-vol-7/499694966' WHERE id = 34109 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34109 Concerto for 2 Chalumeaux in D minor, TWV 52:d1 (spotify: Telemann: Wind Concertos, Vol. 7)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6wGqBSjaVjNyo1AEmygUdL' WHERE id = 34109 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34110 Concerto for 2 Oboes and Trumpet, TWV 53:D2 (apple: Telemann, G.P.: Trumpet Music (Telemann for Trumpet))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-g-p-trumpet-music-telemann-for-trumpet/559889730' WHERE id = 34110 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34110 Concerto for 2 Oboes and Trumpet, TWV 53:D2 (spotify: Trumpet Recital: Friedrich, Reinhold - Endler, J.S. / Telemann, G.P. / Fasch, J.F. (Baroque Trumpet Concertos))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5Y9ltBeH1wG4EBpSmrIb2Y' WHERE id = 34110 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34111 Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3 (apple: Telemann: The Grand Concertos for Mixed Instruments, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-the-grand-concertos-for-mixed-instruments-vol-3/1112264864' WHERE id = 34111 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34111 Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3 (spotify: Telemann: The Grand Concertos for Mixed Instruments, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2lpeNaQzGcFlDBtBfZyJGi' WHERE id = 34111 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34112 Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2 (apple: Telemann: Concerti per molti stromenti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-concerti-per-molti-stromenti/1217384265' WHERE id = 34112 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34112 Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2 (spotify: Telemann: Horn Concertos and Overtures)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1Tu6yp7BRInSmb59YPCqjE' WHERE id = 34112 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34113 Concerto polonois in G major, TWV 43:G7 (apple: Le théâtre musical de Telemann)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/le-theatre-musical-de-telemann/1571722758' WHERE id = 34113 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34113 Concerto polonois in G major, TWV 43:G7 (spotify: Telemann: String Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2wi5nxBZolLVjsxlMRJj8j' WHERE id = 34113 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34118 12 Fantasias for Violin without Bass, TWV 40:14-25 (apple: Telemann: 12 Fantasias for Violin without Bass and 6 Sonatinas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-12-fantasias-for-violin-without-bass-and-6-sonatinas/1390022751' WHERE id = 34118 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34118 12 Fantasias for Violin without Bass, TWV 40:14-25 (spotify: Telemann: 12 Fantasias for Violin without Bass and 6 Sonatinas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0sUB0EJvh2xsm0pkM3bfFC' WHERE id = 34118 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34123 Sonata in F minor for bassoon, TWV 41:f1 (apple: Telemann: Sonatas, Sonatinas and Fantasias)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-sonatas-sonatinas-and-fantasias/1583524671' WHERE id = 34123 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34123 Sonata in F minor for bassoon, TWV 41:f1 (spotify: Bassoon Extravaganza: Milan Turkovic)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6Np71LUsWNDRvBJQC7gwZ6' WHERE id = 34123 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34124 Concerto for Four Violins in G major, TWV 40:201 (apple: Telemann: Sinfonia Spirituosa & String Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-sinfonia-spirituosa-string-concertos/1452942656' WHERE id = 34124 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34124 Concerto for Four Violins in G major, TWV 40:201 (spotify: Telemann: Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/76qS9LjJHk22lC1S7TGoWj' WHERE id = 34124 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34126 Pimpinone, TWV 21:15 (apple: Telemann: Pimpinone, TWV 21:15)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-pimpinone-twv-21-15/1622215218' WHERE id = 34126 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34126 Pimpinone, TWV 21:15 (spotify: Telemann: Pimpinone, TWV 21:15)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/23BpfIKanlfPlI22sZiRQe' WHERE id = 34126 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34128 Miriways, TWV 21:24 (apple: Telemann: Miriways)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-miriways/830597153' WHERE id = 34128 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34128 Miriways, TWV 21:24 (spotify: Telemann: Miriways)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7ro3Yp6PPwDMBOmsd6M1lE' WHERE id = 34128 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34130 Flavius Bertaridus, König der Longobarden (apple: Telemann: Flavius Bertaridus, TWV 21:27)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-flavius-bertaridus-twv-21-27/533682567' WHERE id = 34130 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34130 Flavius Bertaridus, König der Longobarden (spotify: Telemann: Flavius Bertaridus)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0ripEsQZaH4NTdwwH7PNri' WHERE id = 34130 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34132 Brockes-Passion, TWV 5:1 (spotify: Telemann: Brockes-Passion)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/62E4Ev0A1xR7ECqvoGUxGs' WHERE id = 34132 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34133 Lukaspassion, TWV 5:13 "Israel, achigeliebtes Vater-Herz!" (apple: Telemann: St. Luke Passion)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-st-luke-passion/646932793' WHERE id = 34133 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34133 Lukaspassion, TWV 5:13 "Israel, achigeliebtes Vater-Herz!" (spotify: Telemann: St. Luke Passion)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0vtKTIM9GoHeTDwINL3rzs' WHERE id = 34133 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34135 Matthäus Passion, TWV 5:31 "Lasst uns mit Ernst betrachten" (apple: Telemann: A Portrait)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-a-portrait/1572121476' WHERE id = 34135 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34137 Der Tod Jesu, TWV 5:6 (apple: Telemann: Der Tod Jesu, TWV 5:6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-der-tod-jesu-twv-5-6/1454031037' WHERE id = 34137 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34137 Der Tod Jesu, TWV 5:6 (spotify: Telemann: Der Tod Jesu, TWV 5:6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/17eZ9GCoTYSV8m847KA7gf' WHERE id = 34137 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34138 Der Messias TWV 6:4 (apple: Telemann: Der Messias - Septet in A Minor - Quintet in F Major - Quartet in E Flat Major)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-der-messias-septet-in-a-minor-quintet-in-f-major-quartet-in-e-flat-major/361212487' WHERE id = 34138 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34138 Der Messias TWV 6:4 (spotify: Telemann: Der Messias, TWV 6:4 & Einweihungskantate für die Rellinger Kirche)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7oc6btGQsyHNGVYAHk289B' WHERE id = 34138 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34139 Die Auferstehung, TWV 6:7 (apple: Telemann: Die Auferstehung, TWV 6:7 & De danske, norske og tydske undersåtters glæde, TWV 12:10)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-die-auferstehung-twv-6-7-de-danske-norske-og-tydske-undersatters-gl-de-twv-12-10/1454009684' WHERE id = 34139 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34140 Der Tag des Gerichts, TWV 6:8 (apple: Telemann: Der Tag des Gerichts (The Day of Judgements))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-der-tag-des-gerichts-the-day-of-judgements/466559095' WHERE id = 34140 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34140 Der Tag des Gerichts, TWV 6:8 (spotify: Telemann : Der Tag des Gerichts [The Day of Judgement], Ino)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5oMWXkZoFaaD4azFIPqSdU' WHERE id = 34140 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34141 Die Tageszeiten, TWV 20:39 (apple: Telemann: Die Tageszeiten - Daran ist erschienen die Liebe Gottes)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-die-tageszeiten-daran-ist-erschienen-die-liebe-gottes/401025452' WHERE id = 34141 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34141 Die Tageszeiten, TWV 20:39 (spotify: Telemann: Die Tageszeiten / Daran ist erschienen die Liebe Gottes)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2isYGtaSC4pH9KCKoPv3vn' WHERE id = 34141 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34142 Trauer-musik eines kunsterfahrenen Canarienvogels, TWV 20:37 (apple: Telemann: Cantatas (Secular) - TWV 20:37, 48, 57, 66)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-cantatas-secular-twv-20-37-48-57-66/330857616' WHERE id = 34142 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34142 Trauer-musik eines kunsterfahrenen Canarienvogels, TWV 20:37 (spotify: Music@Menlo Live: Creative Capitals, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5XcpTdp6lOVCSC993jZGcj' WHERE id = 34142 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34143 Ino, TWV 20:41 (apple: Telemann: Ino - Opera Arias for Soprano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-ino-opera-arias-for-soprano/1820209363' WHERE id = 34143 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34143 Ino, TWV 20:41 (spotify: Telemann : Der Tag des Gerichts [The Day of Judgement], Ino)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5oMWXkZoFaaD4azFIPqSdU' WHERE id = 34143 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 34145 Lateinisches Magnificat C-Dur, TVWV 9:17 (apple: Telemann: Lateinisches Magnificat)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-lateinisches-magnificat/1328943100' WHERE id = 34145 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34145 Lateinisches Magnificat C-Dur, TVWV 9:17 (spotify: Telemann: Lateinisches Magnificat, TWV 9:17 & Jauchze, jubiliere und singe, TWV 15:5a)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5NnqD85E72rtoUcZNvSIKc' WHERE id = 34145 AND composer_id = 11 AND (spotify_url IS NULL OR spotify_url = '');
-- 33956 Orchestral Trio in C minor, op. 4 no. 3 (apple: Johann Stamitz: Orchestra Trios Volume 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/johann-stamitz-orchestra-trios-volume-1/19554160' WHERE id = 33956 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33956 Orchestral Trio in C minor, op. 4 no. 3 (spotify: Stamitz, J.: Orchestral Trios Nos. 1 - 3, Op. 1 and No. 3, Op. 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4R0Y6njtTZKZsQfRaNG5Fu' WHERE id = 33956 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33957 Orchestral Trio in E major, op. 5 no. 3 (apple: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-vol-1/1757757918' WHERE id = 33957 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33957 Orchestral Trio in E major, op. 5 no. 3 (spotify: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/00oIVVWJsmPe1XI2CqaxRY' WHERE id = 33957 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33958 Symphony in G major, op. 3 no. 1, WolS G2 (apple: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-op-3-nos-1-3-6/1469470537' WHERE id = 33958 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33958 Symphony in G major, op. 3 no. 1, WolS G2 (spotify: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0BjHSJrWpDMWVQhdMHQcVF' WHERE id = 33958 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33959 Symphony in G major, op. 3 no. 3, WolS G3 (apple: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-op-3-nos-1-3-6/1469470537' WHERE id = 33959 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33959 Symphony in G major, op. 3 no. 3, WolS G3 (spotify: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0BjHSJrWpDMWVQhdMHQcVF' WHERE id = 33959 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33960 Symphony in E-flat major, op. 3 no. 4, WolS Eb3 (apple: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-op-3-nos-1-3-6/1469470537' WHERE id = 33960 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33960 Symphony in E-flat major, op. 3 no. 4, WolS Eb3 (spotify: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0BjHSJrWpDMWVQhdMHQcVF' WHERE id = 33960 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33961 Symphony in F major, op. 3 no. 6, WolS F2 (apple: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-op-3-nos-1-3-6/1469470537' WHERE id = 33961 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33961 Symphony in F major, op. 3 no. 6, WolS F2 (spotify: Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0BjHSJrWpDMWVQhdMHQcVF' WHERE id = 33961 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33962 Symphony in F major, op. 4 no. 1 (Wolf F3) (spotify: Stamitz, J.: Symphonies, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5PNcBSeH5yR7qHVXL1LlcG' WHERE id = 33962 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33963 Sinfonia Pastorale in D major, op. 4 no. 2 (Wolf D4) (spotify: Stamitz, J.: Symphonies, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5PNcBSeH5yR7qHVXL1LlcG' WHERE id = 33963 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33964 Symphony in E-flat major, op. 4 no. 4 (Wolf Eb4) (spotify: Stamitz, J.: Symphonies, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5PNcBSeH5yR7qHVXL1LlcG' WHERE id = 33964 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33965 Symphony in E-flat major, op. 4 no. 6 (Wolf Eb5) (spotify: Stamitz, J.: Symphonies, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5PNcBSeH5yR7qHVXL1LlcG' WHERE id = 33965 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33966 Symphony in E-flat major, op. 11 no. 3 (apple: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-vol-1/19544611' WHERE id = 33966 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33966 Symphony in E-flat major, op. 11 no. 3 (spotify: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/00oIVVWJsmPe1XI2CqaxRY' WHERE id = 33966 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33967 Symphony in A major "Mannheim no. 2" (spotify: Stamitz, J.: Symphony in A Major / Symphony in G Major / Viola Concerto in D Major / Sinfonia Concertante in D Major)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5ZyB7tNzIYMdL4xbVkGPyW' WHERE id = 33967 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33968 Symphony in B-flat major "Mannheim no. 3" (apple: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-symphonies-vol-1/1757757918' WHERE id = 33968 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33968 Symphony in B-flat major "Mannheim no. 3" (spotify: Stamitz: Symphonies, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/00oIVVWJsmPe1XI2CqaxRY' WHERE id = 33968 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33969 Sinfonia A 4 in D major (spotify: Birth of the Symphony: Handel to Haydn)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1ZUdiFMhtJBLmS0xZWRjid' WHERE id = 33969 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33970 Flute Concerto in C major (apple: C., A. & J. Stamitz: Flute Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/c-a-j-stamitz-flute-concertos/1594712193' WHERE id = 33970 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33970 Flute Concerto in C major (spotify: C., A. & J. Stamitz: Flute Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3XkFqBWvX3UAh3XRdWzW9d' WHERE id = 33970 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33971 Flute Concerto in G major (apple: Stamitz, J.: Flute Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-j-flute-concertos/338250024' WHERE id = 33971 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33971 Flute Concerto in G major (spotify: Stamitz, J.: Flute Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0vEzVd7F6qAjTVXdEHhk6k' WHERE id = 33971 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33972 Concerto for Viola and Orchestra in G major (apple: Stamitz & Sons: Concertos for Viola)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-sons-concertos-for-viola/1398007289' WHERE id = 33972 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33972 Concerto for Viola and Orchestra in G major (spotify: Stamitz & Sons: Concertos for Viola)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0xTXtO1cwI7xl2CrD1gEvt' WHERE id = 33972 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33973 Konzert für Violine und Streichorchester C-Dur (spotify: Die Mannheimer Schule)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2urEV3tR42KMw9Xra83xEb' WHERE id = 33973 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33974 6 Violin Sonatas, op. 6 (apple: Stamitz: Violin Sonatas, Op. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stamitz-violin-sonatas-op-6/960161957' WHERE id = 33974 AND composer_id = 24 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33974 6 Violin Sonatas, op. 6 (spotify: Stamitz: Violin Sonatas, Op. 6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5vrO5iHSi59y34I4jT4hLN' WHERE id = 33974 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33975 2 Divertimenti for Solo Violin (spotify: Sonatas For Solo Violin)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4jIWyeTN1AxLh64mQkQf6M' WHERE id = 33975 AND composer_id = 24 AND (spotify_url IS NULL OR spotify_url = '');
-- 33916 Sonata in A-flat major, WoO 13 (apple: Clementi: Monferrinas, WoO 15-20 &, Op. 49)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-monferrinas-woo-15-20-op-49/1246994867' WHERE id = 33916 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33916 Sonata in A-flat major, WoO 13 (spotify: Clementi: Complete Piano Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6Mo4YpLHHrQXAmwdaKkflb' WHERE id = 33916 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33917 Sonata in G major, WoO 14 (apple: Clementi, M.: Early Piano Sonatas, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-m-early-piano-sonatas-vol-1/29773909' WHERE id = 33917 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33917 Sonata in G major, WoO 14 (spotify: Clementi: Complete Sonatas for Fortepiano, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2xk599bQjGD1oRt6PH35Qf' WHERE id = 33917 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33918 6 Piano Sonatas, op. 1 (apple: Clementi: Piano Sonatas, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-piano-sonatas-vol-1/1482130816' WHERE id = 33918 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33918 6 Piano Sonatas, op. 1 (spotify: Clementi: Complete Piano Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6Mo4YpLHHrQXAmwdaKkflb' WHERE id = 33918 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33919 5 Piano Sonatas and a Duet, op. 1a (apple: Clementi: Complete Sonatas for Fortepiano, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-sonatas-for-fortepiano-vol-1/745258767' WHERE id = 33919 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33920 3 Piano Sonatas, op. 2 (apple: Muzio Clementi: Complete Piano Works, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muzio-clementi-complete-piano-works-vol-2/651991400' WHERE id = 33920 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33921 3 Piano Sonatas, op. 7 (apple: Muzio Clementi: Complete Piano Works, Vol. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muzio-clementi-complete-piano-works-vol-6/660437178' WHERE id = 33921 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33921 3 Piano Sonatas, op. 7 (spotify: Clementi: Complete Piano Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6Mo4YpLHHrQXAmwdaKkflb' WHERE id = 33921 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33922 3 Piano Sonatas, op. 8 (apple: Clementi: Complete Piano Sonatas, Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-1/1721139739' WHERE id = 33922 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33922 3 Piano Sonatas, op. 8 (spotify: Clementi: Complete Piano Sonatas, Vol. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6Mo4YpLHHrQXAmwdaKkflb' WHERE id = 33922 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33923 3 Piano Sonatas, op. 9 (apple: Muzio Clementi: Complete Piano Works, Vol. 7)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muzio-clementi-complete-piano-works-vol-7/660411708' WHERE id = 33923 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33923 3 Piano Sonatas, op. 9 (spotify: Clementi: Complete Piano Sonatas, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20XKEuZYjCoviTAi7aGTEG' WHERE id = 33923 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33924 3 Piano Sonatas, op. 10 (apple: Muzio Clementi: Complete Piano Works, Vol. 8)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muzio-clementi-complete-piano-works-vol-8/660408249' WHERE id = 33924 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33924 3 Piano Sonatas, op. 10 (spotify: Clementi: Complete Piano Sonatas, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20XKEuZYjCoviTAi7aGTEG' WHERE id = 33924 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33925 Sonata in E-flat major, op. 11 no. 1 (apple: Clementi: Complete Piano Sonatas, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-2/1721142183' WHERE id = 33925 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33925 Sonata in E-flat major, op. 11 no. 1 (spotify: Clementi: Complete Piano Sonatas, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20XKEuZYjCoviTAi7aGTEG' WHERE id = 33925 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33926 Toccata in B-flat major, op. 11 no. 2 (apple: Clementi: Piano Jewels)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/piano-sonata-toccata-op-11-no-2-in-b-flat-major-toccata/1604951772?i=1604951776' WHERE id = 33926 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33926 Toccata in B-flat major, op. 11 no. 2 (spotify: Clementi: Piano Jewels)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1nAlU6xe256uudH2nPf9jl' WHERE id = 33926 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33927 4 Piano Sonatas, op. 12 (apple: Muzio Clementi: 4 Piano Sonatas, Op. 12)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muzio-clementi-4-piano-sonatas-op-12/1479730077' WHERE id = 33927 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33927 4 Piano Sonatas, op. 12 (spotify: Clementi: Complete Piano Sonatas, Vol. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20XKEuZYjCoviTAi7aGTEG' WHERE id = 33927 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33928 6 Sonatas, op. 13 (apple: Clementi: The Complete Sonatas Vol. III)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-the-complete-sonatas-vol-iii/672661002' WHERE id = 33928 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33928 6 Sonatas, op. 13 (spotify: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y9QTg0vIBkSdHclOaOx8B' WHERE id = 33928 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33929 La chasse, op. 16 (apple: Clementi: Piano Jewels)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-piano-jewels/1604951772' WHERE id = 33929 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33929 La chasse, op. 16 (spotify: Clementi: Capriccios & Variations for Piano)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/32n5gWbMe4QMxSlEMa93iE' WHERE id = 33929 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33930 Capriccio in B-flat major, op. 17 (apple: Clementi: Capriccio No. 1, Op. 17 - Piano Sonata Op. 40-3 - Capriccio No. 4, Op. 47-1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/capriccio-no-1-in-b-flat-major-op-17/337043203?i=337043229' WHERE id = 33930 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33930 Capriccio in B-flat major, op. 17 (spotify: Clementi: Capriccio No. 1, Op. 17 / Piano Sonata Op. 40/3 / Capriccio No. 4, Op. 47/1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5u7cYLbkFsK22l4dzUxvTB' WHERE id = 33930 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33931 Two Symphonies, op. 18 (apple: Clementi: Piano Concerto in C Major (1796) - Two Symphonies, Op. 18)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-piano-concerto-in-c-major-1796-two-symphonies-op-18/894923675' WHERE id = 33931 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33931 Two Symphonies, op. 18 (spotify: Clementi: Piano Concerto in C Major (1796) - Two Symphonies, Op. 18)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/20Ao9dCEzFeFDI49jjShcW' WHERE id = 33931 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33932 Musical Characteristics, op. 19 (apple: Clementi: Capriccios & Variations for Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-capriccios-variations-for-piano/1721141227' WHERE id = 33932 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33932 Musical Characteristics, op. 19 (spotify: Clementi: Capriccios & Variations for Piano)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/32n5gWbMe4QMxSlEMa93iE' WHERE id = 33932 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33933 Sonata in C major, op. 20 (apple: M. Clementi: Early Piano Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/m-clementi-early-piano-sonatas-vol-3/322700663' WHERE id = 33933 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33933 Sonata in C major, op. 20 (spotify: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y9QTg0vIBkSdHclOaOx8B' WHERE id = 33933 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33934 Sonata in F major, WO3 (apple: M. Clementi: Early Piano Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/m-clementi-early-piano-sonatas-vol-3/322700663' WHERE id = 33934 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33934 Sonata in F major, WO3 (spotify: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y9QTg0vIBkSdHclOaOx8B' WHERE id = 33934 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33935 3 Piano Sonatas, op. 23 (apple: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-3/1721136971' WHERE id = 33935 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33935 3 Piano Sonatas, op. 23 (spotify: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y9QTg0vIBkSdHclOaOx8B' WHERE id = 33935 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33936 2 Piano Sonatas, op. 24 (spotify: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y9QTg0vIBkSdHclOaOx8B' WHERE id = 33936 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33937 6 Piano Sonatas, op. 25 (apple: Clementi: Complete Piano Sonatas, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-4/1721143832' WHERE id = 33937 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33937 6 Piano Sonatas, op. 25 (spotify: Clementi: Complete Piano Sonatas, Vol. 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0tcKU03dptwbkniTduzfGN' WHERE id = 33937 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33938 Sonata in F major, op. 26 (apple: Clementi: Keyboard Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-keyboard-sonatas/1488800137' WHERE id = 33938 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33938 Sonata in F major, op. 26 (spotify: Clementi: Keyboard Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6hyhmoyPQjidIEMzfhOzcG' WHERE id = 33938 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33939 3 Piano Sonatas, op. 33 (apple: Clementi: Complete Piano Sonatas, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-4/1721143832' WHERE id = 33939 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33939 3 Piano Sonatas, op. 33 (spotify: Clementi: The Complete Sonatas, Vol. IV)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2QaVQ0xNA6MlWhJnvVCRuc' WHERE id = 33939 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33940 2 Piano Sonatas and 2 Capriccios, op. 34 (apple: Clementi: Complete Sonatas for Fortepiano, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-sonatas-for-fortepiano-vol-3/748245964' WHERE id = 33940 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33941 Piano Concerto in C major (apple: Clementi - Complete Piano Works Vol. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-works-vol-1/504848669' WHERE id = 33941 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33941 Piano Concerto in C major (spotify: 100 Harmonious Classics for Study and Homework)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1mbiFXD1dHztEnU8UEDBjz' WHERE id = 33941 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33942 3 Piano Sonatas, op. 37 (apple: Clementi: Complete Piano Sonatas, Vol. 5)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-5/1721142182' WHERE id = 33942 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33942 3 Piano Sonatas, op. 37 (spotify: Clementi: Complete Sonatas, Vol. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2uOnb1wadM4FPQ2oTHtAVz' WHERE id = 33942 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33943 3 Piano Sonatas, op. 40 (apple: Clementi: Piano Sonatas, Op. 40)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-piano-sonatas-op-40/3326796' WHERE id = 33943 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33943 3 Piano Sonatas, op. 40 (spotify: CLEMENTI: Piano Sonatas, Op. 40)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/53ePtMeucojwMuv1wuO9fx' WHERE id = 33943 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33944 Sonata in E-flat major, op. 41 (apple: Clementi: Sonatas Op. 50/1, Op. 34/2 and Op. 41)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-sonatas-op-50-1-op-34-2-and-op-41/121010315' WHERE id = 33944 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33944 Sonata in E-flat major, op. 41 (spotify: Clementi: Piano Sonatas, Op. 50: No. 1, Op. 34: No. 2 and Op. 41)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0EBXMiXEffTNDFaKpTa3dx' WHERE id = 33944 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33945 Sonata in B-flat major, op. 46 (apple: Clementi: Keyboard Sonatas, Opp. 25, 33 & 46)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-keyboard-sonatas-opp-25-33-46/1410410074' WHERE id = 33945 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33945 Sonata in B-flat major, op. 46 (spotify: Clementi: Complete Piano Sonatas, Vol. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2ER604RQeAxdo46WrXv9H5' WHERE id = 33945 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33946 Variations on “Batti batti” from Mozart’s “Don Giovanni”, WoO 10 (apple: Clementi: Piano Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/variations-on-mozarts-batti-batti-woo-10/1518631576?i=1518632021' WHERE id = 33946 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33946 Variations on “Batti batti” from Mozart’s “Don Giovanni”, WoO 10 (spotify: Clementi: Piano Sonatas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2BWujr8oloThvOszMgSfFQ' WHERE id = 33946 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33947 2 Capriccios, op. 47 (apple: Clementi: Piano Jewels)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-piano-jewels/1604951772' WHERE id = 33947 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33947 2 Capriccios, op. 47 (spotify: Clementi: Sonate, Duetti & Capricci - Vol. 14)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4Y1SNGfIy2SpziIjChwtat' WHERE id = 33947 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33948 Fantaisie and Variations on "Au clair de la lune", op. 48 (apple: Clementi: Capriccios & Variations for Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/fantaisie-and-variations-on-au-clair-de-la-lune-op-48/1721141227?i=1721141628' WHERE id = 33948 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33948 Fantaisie and Variations on "Au clair de la lune", op. 48 (spotify: Clementi: Keyboard Sonatas & Fantasia con variazioni)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4WYFRFgYUuLFpwNIz4DmR5' WHERE id = 33948 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33949 12 monferrinas, op. 49 (apple: Clementi: Monferrinas, WoO 15-20 &, Op. 49)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-monferrinas-woo-15-20-op-49/1246994867' WHERE id = 33949 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33949 12 monferrinas, op. 49 (spotify: Clementi: Monferrinas, WoO 15-20 & Op. 49)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3EtNuQX1i1FrsSfBYpqvBa' WHERE id = 33949 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33950 3 Piano Sonatas, op. 50 (apple: Clementi: The Piano Sonatas, Op. 40 & Op. 50)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-the-piano-sonatas-op-40-op-50/1498246913' WHERE id = 33950 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33950 3 Piano Sonatas, op. 50 (spotify: Clementi: Complete Piano Sonatas, Vol. 6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2V5kHnk1E2IGdOS8ldptZW' WHERE id = 33950 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33951 Symphony no. 1 in C major, WoO 32 (apple: Clementi: Symphonies Nos. 1 & 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-symphonies-nos-1-2/586738907' WHERE id = 33951 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33951 Symphony no. 1 in C major, WoO 32 (spotify: Clementi: Symphonies)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7MRHryyc2gJppTRlngJVsD' WHERE id = 33951 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33952 Symphony no. 2 in D major, WoO 33 (apple: Clementi: Symphonies Nos. 1 & 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-symphonies-nos-1-2/586738907' WHERE id = 33952 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33952 Symphony no. 2 in D major, WoO 33 (spotify: Clementi : Symphonies Nos 1 - 4 (Apex))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2TWnCpMFa3aBlNoeAKCs1B' WHERE id = 33952 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33954 Symphony no. 4 in D major, WoO 35 (apple: Clementi: Symphonies Nos. 3 & 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-symphonies-nos-3-4/696107810' WHERE id = 33954 AND composer_id = 25 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33954 Symphony no. 4 in D major, WoO 35 (spotify: Clementi: Symphonies Nos. 3 & 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1QlKoCaFytWTt6RpCQMRmJ' WHERE id = 33954 AND composer_id = 25 AND (spotify_url IS NULL OR spotify_url = '');
-- 33978 String Quartet in D major (apple: Zemlinsky: String Quartet No. 2, Op. 15 - Schoenberg: String Quartet in D Major)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/zemlinsky-string-quartet-no-2-op-15-schoenberg-string-quartet-in-d-major/1150160555' WHERE id = 33978 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33978 String Quartet in D major (spotify: Schoenberg: Complete Works for Strings)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4eOhMdwGuD8E8lmLQPPkUP' WHERE id = 33978 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33979 Zwei Gesänge, op. 1 (apple: The Music of Arnold Schoenberg, Vol. 4: The Complete Music for Solo Piano and Songs for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/the-music-of-arnold-schoenberg-vol-4-the-complete-music-for-solo-piano-and-songs-for-voice-piano/1005066970' WHERE id = 33979 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33979 Zwei Gesänge, op. 1 (spotify: Schoenberg: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/15G5aqacpTZVBgVJfcs2sS' WHERE id = 33979 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33980 Vier Lieder, op. 2 (apple: The Music of Arnold Schoenberg, Vol. 4: The Complete Music for Solo Piano and Songs for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/the-music-of-arnold-schoenberg-vol-4-the-complete-music-for-solo-piano-and-songs-for-voice-piano/1005066970' WHERE id = 33980 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33980 Vier Lieder, op. 2 (spotify: Schönberg: Complete Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5scTyFkA1NADWXYdnJS0Vw' WHERE id = 33980 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33981 Brettl-Lieder (apple: Schoenberg: 3 Song Cycles)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-3-song-cycles/456256395' WHERE id = 33981 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33981 Brettl-Lieder (spotify: Schönberg: Complete Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5scTyFkA1NADWXYdnJS0Vw' WHERE id = 33981 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33982 Sechs Lieder, op. 3 (apple: Schoenberg: Complete Songs, Vol. 2 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-complete-songs-vol-2-gould-remastered/1016550851' WHERE id = 33982 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33982 Sechs Lieder, op. 3 (spotify: Schoenberg: Complete Songs, Vol. 2 (Gould Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4elPnRCpccQGxtazimCcpS' WHERE id = 33982 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33983 Pelleas und Melisande, op. 5 (apple: Schoenberg: Verklärte Nacht, Op. 4; Pelléas und Mélisande, Op. 5)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-verklarte-nacht-op-4-pelleas-und-melisande-op-5/1452350866' WHERE id = 33983 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33983 Pelleas und Melisande, op. 5 (spotify: Schoenberg: Pelleas und Melisande, Op. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2pMDpIkdH5Bdn0T21Ge70Z' WHERE id = 33983 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33984 Acht Lieder, op. 6 (apple: Schoenberg: Complete Songs, Vol. 2 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-complete-songs-vol-2-gould-remastered/1016550851' WHERE id = 33984 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33984 Acht Lieder, op. 6 (spotify: Schoenberg: The Hanging Gardens)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/37EgZgL425BrEDh7fM06Mn' WHERE id = 33984 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33985 String Quartet no. 1 in D minor, op. 7 (apple: Schoenberg: String Quartet No. 1 & Verklärte Nacht)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-string-quartet-no-1-verklarte-nacht/691205526' WHERE id = 33985 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33985 String Quartet no. 1 in D minor, op. 7 (spotify: Schoenberg: String Quartet No. 1 & Verklärte Nacht)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/36HEzYHawTl7yJLf1N9IGf' WHERE id = 33985 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33986 6 Orchester-Lieder, op. 8 (apple: Schoenberg: 6 Orchestral Songs, Kol Nidre & Friede Auf Erden)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-6-orchestral-songs-kol-nidre-friede-auf-erden/265884742' WHERE id = 33986 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33986 6 Orchester-Lieder, op. 8 (spotify: Schoenberg: 6 Orchestral Songs / Kol Nidre / Friede Auf Erden)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/71yL7V10XsWtOkW8EB88Ne' WHERE id = 33986 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33987 Chamber Symphony no. 1, op. 9 (apple: Schoenberg, A.: Verklarte Nacht - Chamber Symphony No. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-a-verklarte-nacht-chamber-symphony-no-1/557895429' WHERE id = 33987 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33987 Chamber Symphony no. 1, op. 9 (spotify: Schoenberg: Verklärte Nacht; Chamber Symphonies Nos. 1 & 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4f7znAakJmgDdLhJikPLjz' WHERE id = 33987 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33988 Zwei Balladen, op. 12 (apple: Schoenberg: Complete Songs, Vol. 2 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-complete-songs-vol-2-gould-remastered/1016550851' WHERE id = 33988 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33988 Zwei Balladen, op. 12 (spotify: Schoenberg: Complete Songs, Vol. 2 (Gould Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4elPnRCpccQGxtazimCcpS' WHERE id = 33988 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33989 Friede auf Erden, op. 13 (apple: SCHOENBERG: PELLEAS UND MELISANDE "SYMPHONISCHE DICHTUNG FÜR ORCHESTER"; FRIEDE AUF ERDEN; ERWARTUNG (AUFNAHME OHNE SOLOSTIMME))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/friede-auf-erden-in-d-minor-op-13-ias-5/1680561444?i=1680562554' WHERE id = 33989 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33989 Friede auf Erden, op. 13 (spotify: Treasures)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5DEfjh0a8f3rT6FpwV6U6B' WHERE id = 33989 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33990 String Quartet no. 2 in F-sharp minor, op. 10 (apple: Berg: String Quartet – Webern: Langsamer Satz – Schoenberg: String Quartet No. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/berg-string-quartet-webern-langsamer-satz-schoenberg-string-quartet-no-2/1627736211' WHERE id = 33990 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33990 String Quartet no. 2 in F-sharp minor, op. 10 (spotify: Berg: String Quartet – Webern: Langsamer Satz – Schoenberg: String Quartet No. 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/52183bglMbhFc54bcBtW8X' WHERE id = 33990 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33991 Zwei Lieder, op. 14 (apple: Schoenberg: Complete Songs, Vol. 2 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-complete-songs-vol-2-gould-remastered/1016550851' WHERE id = 33991 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33991 Zwei Lieder, op. 14 (spotify: Schoenberg: Complete Songs, Vol. 2 (Gould Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4elPnRCpccQGxtazimCcpS' WHERE id = 33991 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33992 Drei Klavierstücke, op. 11 (apple: Berg: Piano Sonata, Op. 1 - Schoenberg: Three Piano Pieces, Op. 11 - Krenek: Piano Sonata No. 3, Op. 92, No. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/berg-piano-sonata-op-1-schoenberg-three-piano-pieces-op-11-krenek-piano-sonata-no-3-op-92-no-4/1005220455' WHERE id = 33992 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33992 Drei Klavierstücke, op. 11 (spotify: Schönberg: Piano Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1HjteVzNzmMgIbGM3ROWce' WHERE id = 33992 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33993 Das Buch der hängenden Gärten, op. 15 (apple: Arnold Schoenberg: Das Buch der hängenden Gärten)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/arnold-schoenberg-das-buch-der-hangenden-garten/1595960032' WHERE id = 33993 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33993 Das Buch der hängenden Gärten, op. 15 (spotify: Lieder Vol.4 [Mahler/Schönberg/Milhaud])
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5Ptej1zJ9TmPWHCiXkAiKf' WHERE id = 33993 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33994 Fünf Orchesterstücke, op. 16 (apple: Schoenberg: 5 Pieces for Orchestra, Op. 16; Webern: 5 Pieces for Orchestra, Op. 10; Berg: Three Pieces for Orchestra, Op. 6 / Lulu Suite)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-5-pieces-for-orchestra-op-16-webern-5-pieces-for-orchestra-op-10-berg-three-pieces-for-orchestra-op-6-lulu-suite/1597388643' WHERE id = 33994 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33994 Fünf Orchesterstücke, op. 16 (spotify: Schoenberg: Five Pieces for Orchestra Op. 16; Webern: Five Pieces for Orchestra, Op. 10; Berg: Three Pieces for Orchestra)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2OrKEU3CXwfEXOPF4OK58n' WHERE id = 33994 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33995 Erwartung, op. 17 (apple: Schoenberg: Erwartung)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-erwartung/1761626019' WHERE id = 33995 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33995 Erwartung, op. 17 (spotify: Schoenberg: Erwartung; Cabaret Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0z5mEWh4yp6my6roqe6mxy' WHERE id = 33995 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33996 3 Pieces for Chamber Orchestra (apple: Schoenberg: Suite, Op. 29; Verklärte Nacht; Three Pieces for Chamber Orchestra)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-suite-op-29-verklarte-nacht-three-pieces-for-chamber-orchestra/458881908' WHERE id = 33996 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33996 3 Pieces for Chamber Orchestra (spotify: Schoenberg: Suite, Op. 29, Verklärte Nacht, Op. 4 & 3 Pieces for Chamber Orchestra)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5nLlmGLcrwkG7wi5777NaW' WHERE id = 33996 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33997 Sechs kleine Klavierstücke, op. 19 (apple: Schoenberg: Sechs kleine Klavierstücke, Op. 19 - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-sechs-kleine-klavierstucke-op-19-ep/943975728' WHERE id = 33997 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33997 Sechs kleine Klavierstücke, op. 19 (spotify: Arnold Schoenberg Sechs kleine Klavierstücke op.19)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4wixg7CYWBSwxtdxEM4O61' WHERE id = 33997 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 33998 Herzgewächse, op. 20 (apple: Schoenberg: Pierrot Lunaire - Herzgewächse - Ode to Napoleon)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/herzgewachse-op-20/1452181812?i=1452182058' WHERE id = 33998 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33998 Herzgewächse, op. 20 (spotify: Schoenberg: Pierrot Lunaire; Herzgewächse; Ode to Napoleon)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7hvDqYDclVH4X6EQf0l441' WHERE id = 33998 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34000 Die glückliche Hand, op. 18 (apple: Schoenberg: Chamber Symphony No. 2, Die Gluckliche Hand, Wind Quintet)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-chamber-symphony-no-2-die-gluckliche-hand-wind-quintet/277620613' WHERE id = 34000 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34000 Die glückliche Hand, op. 18 (spotify: Schoenberg: Die Jakobsleiter & Erwartung, Op. 17 & Die glückliche Hand, Op. 18 & Chamber Symphonies Nos. 1 + 2 & Lieder, Op. 22)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2EOBkAHewVQGN9RculT5aE' WHERE id = 34000 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34001 Vier Lieder, op. 22 (apple: The Music of Arnold Schoenberg, Vol. 3 (2023 Remastered Version))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/the-music-of-arnold-schoenberg-vol-3-2023-remastered-version/1685614385' WHERE id = 34001 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34001 Vier Lieder, op. 22 (spotify: Schoenberg: Pierrot Lunaire / Chamber Symphony No. 1 / 4 Orchestral Songs)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4QosdhYvcXGDGGjQxVgQdp' WHERE id = 34001 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34002 Die Jakobsleiter (apple: Schoenberg: Die Jakobsleiter)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-die-jakobsleiter/1596646702' WHERE id = 34002 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34002 Die Jakobsleiter (spotify: Schoenberg: Die Jakobsleiter & Erwartung, Op. 17 & Die glückliche Hand, Op. 18 & Chamber Symphonies Nos. 1 + 2 & Lieder, Op. 22)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2EOBkAHewVQGN9RculT5aE' WHERE id = 34002 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34003 Serenade, op. 24 (apple: Schoenberg: Serenade & Variations, Op. 31)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-serenade-variations-op-31/151336163' WHERE id = 34003 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34003 Serenade, op. 24 (spotify: Schoenberg: Serenade, Op. 24 & Chamber Symphony No. 1, Op. 9)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6q0Uvq9jikK8Tfw2F1bQQK' WHERE id = 34003 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34004 Suite für Klavier, op. 25 (apple: Stravinsky: Serenade in A Major & Piano Sonata - Schoenberg: Piano Pieces, Op. 33 & Suite for Piano, Op. 25)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/stravinsky-serenade-in-a-major-piano-sonata-schoenberg-piano-pieces-op-33-suite-for-piano-op-25/1086787758' WHERE id = 34004 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34004 Suite für Klavier, op. 25 (spotify: Berg, Schoenberg & Webern: Piano Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5cYfs3YaE6ezbtulHPWTvt' WHERE id = 34004 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34005 Quintett für Flöte, Oboe, Klarinette, Horn und Fagott, op. 26 (apple: Schoenberg: Suite, Op. 29 & Wind Quintet, Op. 26)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-suite-op-29-wind-quintet-op-26/1452188367' WHERE id = 34005 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34005 Quintett für Flöte, Oboe, Klarinette, Horn und Fagott, op. 26 (spotify: Schoenberg: Wind Quintet, Op. 26 (2023 Remastered Version))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/43RWhDwO3BBLywUtpMjy6h' WHERE id = 34005 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34006 4 Stücke für gemischten Chor, op. 27 (apple: Pierre Boulez Conducts Schoenberg)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/pierre-boulez-conducts-schoenberg/609761038' WHERE id = 34006 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34006 4 Stücke für gemischten Chor, op. 27 (spotify: Schönberg: Choral Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5p0QisFJNzgVGEa4lX4hQ6' WHERE id = 34006 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34007 3 Satiren für gemischten Chor, op. 28 (apple: Pierre Boulez Conducts Schoenberg)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/pierre-boulez-conducts-schoenberg/609761038' WHERE id = 34007 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34007 3 Satiren für gemischten Chor, op. 28 (spotify: Pierre Boulez conducts Schoenberg)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3qijM5aY0DIku5hbZVCUlE' WHERE id = 34007 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34008 Suite, op. 29 (apple: Schoenberg: Suite, Op. 29; Verklärte Nacht; Three Pieces for Chamber Orchestra)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-suite-op-29-verklarte-nacht-three-pieces-for-chamber-orchestra/458881908' WHERE id = 34008 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34008 Suite, op. 29 (spotify: Schoenberg: Suite, Op.29; Wind Quintet, Op.26)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5NmJDLdPI4LQWUt7qCQw7V' WHERE id = 34008 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34009 String Quartet no. 3, op. 30 (apple: Schoenberg: String Quartets Nos. 1-4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-string-quartets-nos-1-4/494686752' WHERE id = 34009 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34009 String Quartet no. 3, op. 30 (spotify: Schoenberg: the Four String Quartets)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4x5knWTxWR6jd7lBW7G3E8' WHERE id = 34009 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34010 Variations for Orchestra, op. 31 (apple: Schoenberg: Variations for Orchestra, Op. 31)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-variations-for-orchestra-op-31/1835914477' WHERE id = 34010 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34010 Variations for Orchestra, op. 31 (spotify: Schoenberg: Variations for Orchestra, Op. 31)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3tVVqf3w7zdzgkjj32N9N4' WHERE id = 34010 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34011 Von heute auf morgen, op. 32 (apple: Schoenberg: Von Heute auf Morgen, Op. 32)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-von-heute-auf-morgen-op-32/1453911244' WHERE id = 34011 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34011 Von heute auf morgen, op. 32 (spotify: Schoenberg: Von Heute auf Morgen, Op. 32)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/55WutobOk2xpr1YSdy2mh3' WHERE id = 34011 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34012 Accompaniment to a Cinematographic Scene, op. 34 (apple: Schoenberg: Die Jakobsleiter, Chamber Symphony No. 1, Accompaniment to a Cinematographic Scene)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/accompaniment-to-a-cinematographic-scene-op-34/958528646?i=958528664' WHERE id = 34012 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34012 Accompaniment to a Cinematographic Scene, op. 34 (spotify: Brahms: Piano Quartet No. 1 in G Minor, Op. 25 (Orch. A Schoenberg) - Schoenberg: Accompaniment to a Cinematographic Scene, Op. 34)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3mQttVdN8BqT5yxhUpHRr2' WHERE id = 34012 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34013 Sechs Stücke für Männerchor, op. 35 (apple: Schoenberg: Choral Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-choral-music/466863986' WHERE id = 34013 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34013 Sechs Stücke für Männerchor, op. 35 (spotify: The Music of Arnold Schoenberg, Vol. 8)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6cNYxHuIZtbYEaGUCT0JKB' WHERE id = 34013 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34014 Klavierstücke, op. 33 (apple: Schoenberg: Piano Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-piano-music/1453040765' WHERE id = 34014 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34014 Klavierstücke, op. 33 (spotify: Glenn Gould plays Schoenberg: Klavierstücke opp. 11, 19, 23, 33; Piano Suite op. 25; Piano Concerto op. 42; Fantasy for Violin & Piano op. 47; Ode to Napoleon Buonaparte op. 41; Lieder opp. 1; 2; 3; 6; 12; 14; 15; 48)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6n7PBrw40pBLoWIatDYesI' WHERE id = 34014 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34015 Moses und Aron (apple: Schoenberg: Moses und Aron)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-moses-und-aron/1452619945' WHERE id = 34015 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34015 Moses und Aron (spotify: Schoenberg: Moses und Aron)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5W79qPkusA4VNPJzvkFnub' WHERE id = 34015 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34016 Drei Lieder, op. 48 (apple: Schoenberg: Complete Songs, Vol. 2 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-complete-songs-vol-2-gould-remastered/1016550851' WHERE id = 34016 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34016 Drei Lieder, op. 48 (spotify: Expressionist Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/13mnQ4pzov4jMZACmpAA5l' WHERE id = 34016 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34017 Suite for String Orchestra in G major (apple: Schoenberg in Hollywood)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-in-hollywood/1452198291' WHERE id = 34017 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34017 Suite for String Orchestra in G major (spotify: Schoenberg:Gurrelieder/Suite for String Orchestra)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/34iPmGv0fFcFGAr8qtHZbb' WHERE id = 34017 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34018 Violin Concerto, op. 36 (apple: Schoenberg: Violin Concerto - Sibelius: Violin Concerto, Op. 47)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-violin-concerto-sibelius-violin-concerto-op-47/1452542624' WHERE id = 34018 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34018 Violin Concerto, op. 36 (spotify: Schoenberg: Violin Concerto / Sibelius: Violin Concerto op.47)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0YHrFLfeGjkhEhYSCimYdB' WHERE id = 34018 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34019 String Quartet no. 4, op. 37 (apple: Schoenberg: String Quartet No. 4 - Webern: 5 Movements for String Quartet - Berg: String Quartet, Op. 3 (2021 Remastered Version))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-string-quartet-no-4-webern-5-movements-for-string-quartet-berg-string-quartet-op-3-2021-remastered-version/1570081912' WHERE id = 34019 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34019 String Quartet no. 4, op. 37 (spotify: Schoenberg: String Quartet No. 4 - Webern: 5 Movements for String Quartet - Berg: String Quartet, Op. 3 (2021 Remastered Version))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/77VQxytCfqJ0glxppb8ua0' WHERE id = 34019 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34020 Kol Nidre, op. 39 (apple: Schoenberg: Kol Nidre - Shostakovich: Suite on Verses of Michelangelo Buonarroti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/kol-nidre-op-39/1145122350?i=1145122671' WHERE id = 34020 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34020 Kol Nidre, op. 39 (spotify: Schoenberg: Kol Nidre - Shostakovich: Suite on Verses of Michelangelo Buonarroti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4NHIanxnz6iSiNVg54dvV3' WHERE id = 34020 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34021 Chamber Symphony no. 2, op. 38 (apple: Schoenberg: Chamber Symphony No. 2, Die Gluckliche Hand, Wind Quintet)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-chamber-symphony-no-2-die-gluckliche-hand-wind-quintet/277620613' WHERE id = 34021 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34021 Chamber Symphony no. 2, op. 38 (spotify: Schoenberg: Transfigured Night, Op. 4 & Chamber Symphony No. 2, Op. 38)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3WZIqZxYUDkk1AylmRcD0x' WHERE id = 34021 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34022 Variations on a Recitative, op. 40 (apple: Variations On A Recitative / Mass For The Poor)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/variations-on-a-recitative-mass-for-the-poor/1530139168' WHERE id = 34022 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34022 Variations on a Recitative, op. 40 (spotify: Great European Organs, Vol. 92)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4HTgWihvwRYzzhlW4LclGE' WHERE id = 34022 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34024 Concerto for Piano and Orchestra, op. 42 (apple: Mozart: Piano Concerto No. 24 in C Minor, K. 491 - Schoenberg: Piano Concerto, Op. 42)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/mozart-piano-concerto-no-24-in-c-minor-k-491-schoenberg-piano-concerto-op-42/1004920469' WHERE id = 34024 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34024 Concerto for Piano and Orchestra, op. 42 (spotify: Schumann: Piano Concerto Op.54 / Schoenberg: Piano Concerto Op.42)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6VD4X1HnXMOKsqMiPxt7UT' WHERE id = 34024 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34025 Theme and Variations, op. 43a (apple: Hindemith: Symphony in B-Flat; Schoenberg: Theme & Variations; Stravinsky: Symphonies for Wind)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/hindemith-symphony-in-b-flat-schoenberg-theme-variations-stravinsky-symphonies-for-wind/1452354867' WHERE id = 34025 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34025 Theme and Variations, op. 43a (spotify: Signatures: United States Air Force Band)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0HgsKYZbF7WechRcBlVV2c' WHERE id = 34025 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34026 Genesis Suite: Prelude, op. 44 (apple: Schoenberg: Violin Concerto, Ode to Napoleon, A Survivor from Warsaw)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/prelude-to-genesis-op-44/293139715?i=293139738' WHERE id = 34026 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34026 Genesis Suite: Prelude, op. 44 (spotify: Classical Preludes)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1fpJDu2alipcaYQ5yb0R0Q' WHERE id = 34026 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34027 String Trio, op. 45 (apple: Schoenberg: Verklärte Nacht & String Trio (Remastered))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-verklarte-nacht-string-trio-remastered/1035011910' WHERE id = 34027 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34027 String Trio, op. 45 (spotify: Schoenberg: String Trio - Regamey: Quintet)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0SqKxCyUurjOGXGguQ9WwQ' WHERE id = 34027 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34028 Phantasy for Violin with Piano Accompaniment, op. 47 (apple: Arnold Schoenberg: The 1951 Dial Masters: Phantasy for Violin with Piano Accompaniment, Op. 47, Six Little Piano Pieces, Op. 19 & Five Piano Pieces, Op. 23)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/phantasy-for-violin-with-piano-accompaniment-op-47/865110136?i=865110215' WHERE id = 34028 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34028 Phantasy for Violin with Piano Accompaniment, op. 47 (spotify: Glenn Gould plays Schoenberg: Klavierstücke opp. 11, 19, 23, 33; Piano Suite op. 25; Piano Concerto op. 42; Fantasy for Violin & Piano op. 47; Ode to Napoleon Buonaparte op. 41; Lieder opp. 1; 2; 3; 6; 12; 14; 15; 48)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6n7PBrw40pBLoWIatDYesI' WHERE id = 34028 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34029 Dreimal tausend Jahre, op. 50a (apple: Schoenberg: Violin Concerto, Ode to Napoleon, A Survivor from Warsaw)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/dreimal-tausend-jahre-op-50a/293139715?i=293139740' WHERE id = 34029 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34029 Dreimal tausend Jahre, op. 50a (spotify: Schoenberg, A.: Violin Concerto / Ode To Napoleon / A Survivor From Warsaw)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1ZrRxse1kVHvb5P4WAtVUv' WHERE id = 34029 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 34030 De profundis, op. 50b (apple: Pierre Boulez Conducts Schoenberg)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/de-profundis-op-50b-psalm-130/609761038?i=609767569' WHERE id = 34030 AND composer_id = 82 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34030 De profundis, op. 50b (spotify: New Music in Church)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3hqCjqp5fLIwLARDOkGelq' WHERE id = 34030 AND composer_id = 82 AND (spotify_url IS NULL OR spotify_url = '');
-- 342 Gagok <Balsam Flower (Bongseonhwa)> (apple: The Collection of Immortal Korean Classical Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/balsam-flower/1602146830?i=1602146838' WHERE id = 342 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 342 Gagok <Balsam Flower (Bongseonhwa)> (spotify: 유성기로 듣던 여명의 한국 가곡사)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1YKBNtZtJX0GAZszCmXZnD' WHERE id = 342 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34399 Gagok <Night at Seongbulsa Temple (Seongbulsaui Bam)> (spotify: 한국 애창가곡 1집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1C99EySIPwEW6mUjVt6BFf' WHERE id = 34399 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34400 Gagok <Climbing the Old Hill (Yet Dongsane Olla)> (spotify: 한국 가곡 선집 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/70tYwB3Wq6h86v2DpwTVjq' WHERE id = 34400 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34401 Gagok <Spring Maiden (Bomcheonyeo)> (apple: 한국 가곡 베스트)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EB%B4%84%EC%B2%98%EB%85%80/1495035187?i=1495035199' WHERE id = 34401 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34401 Gagok <Spring Maiden (Bomcheonyeo)> (spotify: 한국 애창가곡 3집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4UalVRxn6vXXrGEAK13IKF' WHERE id = 34401 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34402 Gagok <Jangansa Temple (Jangansa)> (apple: 한국 가곡 베스트)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EC%9E%A5%EC%95%88%EC%82%AC/1495035187?i=1495035263' WHERE id = 34402 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34402 Gagok <Jangansa Temple (Jangansa)> (spotify: 한국 애창가곡 6집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6CvrRmcwtOHU9ROrNBq97r' WHERE id = 34402 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34403 Gagok <I Would Live in Geumgang (Geumgange Sareuriratda)> (apple: 한국 가곡 베스트)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B8%88%EA%B0%95%EC%97%90-%EC%82%B4%EC%9C%BC%EB%A6%AC%EB%9E%8F%EB%8B%A4/1495035187?i=1495035212' WHERE id = 34403 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34404 Gagok <The Boatman's Song (Sagongui Norae)> (apple: 한국 가곡 베스트)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EC%82%AC%EA%B3%B5%EC%9D%98-%EB%85%B8%EB%9E%98/1495035187?i=1495035257' WHERE id = 34404 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34404 Gagok <The Boatman's Song (Sagongui Norae)> (spotify: 한국 애창가곡 4집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2Dz6I4nOYLaGHcLpj3YQT4' WHERE id = 34404 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34405 Gagok <Longing (Geurium)> (apple: 한국 가곡 베스트)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B7%B8%EB%A6%AC%EC%9B%80/1495035187?i=1495035266' WHERE id = 34405 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34405 Gagok <Longing (Geurium)> (spotify: 한국 애창가곡 2집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2ukg3CeFmSKo3x8iVjRk84' WHERE id = 34405 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34406 Gagok <Love (Sarang)> (apple: 한국의 애창가곡집)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EC%82%AC%EB%9E%91-%ED%99%8D%EB%82%9C%ED%8C%8C/1695511066?i=1695511073' WHERE id = 34406 AND composer_id = 89 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34406 Gagok <Love (Sarang)> (spotify: 한국 애창가곡 2집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3ABMvauiiIUHLPmEJ1WvZJ' WHERE id = 34406 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34409 Children's Song <Half Moon in the Daytime (Naje Naon Bandal)> (spotify: 우리들의 동요 1집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4ZvawQivVeX5n8hMjLOAKD' WHERE id = 34409 AND composer_id = 89 AND (spotify_url IS NULL OR spotify_url = '');
-- 34307 Om mani padme hum (apple: Isang Yun: Works, Vol. 11)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-works-vol-11/1626498174' WHERE id = 34307 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34307 Om mani padme hum (spotify: Isang Yun: Works, Vol. 11)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4HC28V0b6GzJDjWfRzJ7Bq' WHERE id = 34307 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34310 An der Schwelle (apple: Isang Yun: Works, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/an-der-schwelle/1619516998?i=1619516999' WHERE id = 34310 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34310 An der Schwelle (spotify: Isang Yun: Works, Vol. 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7wcvfGnnyPwXgM04cqwRrr' WHERE id = 34310 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34312 O Licht (apple: Isang Yun: Works, Vol. 10)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/o-licht/1624933186?i=1624933190' WHERE id = 34312 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34312 O Licht (spotify: Isang Yun: Works, Vol. 10)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4PcHcMU5HVfNYyFWTS1qeb' WHERE id = 34312 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34314 Cantata <My Land, My People!> (apple: Isang Yun: My Land, My People & Exemplum in memoriam Kwangju)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-my-land-my-people-exemplum-in-memoriam-kwangju/394685864' WHERE id = 34314 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34314 Cantata <My Land, My People!> (spotify: Yun: My Land, My People! / Exemplum in Memoriam Kwangju)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2xFHvRC9QbuLuDu3n3RjvE' WHERE id = 34314 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34316 Namo (apple: Isang Yun: Works, Vol. 3 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/namo-live/1618775374?i=1618775441' WHERE id = 34316 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34316 Namo (spotify: Isang Yun: Works, Vol. 3 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4O8wAMGAJnbWRl2iUrL1lm' WHERE id = 34316 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34317 Gagok (apple: Yun: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/gagok/1434450846?i=1434450849' WHERE id = 34317 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34317 Gagok (spotify: Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6ZoCR4ApiqYvb3SgVjNqnq' WHERE id = 34317 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34318 Memory (apple: Isang Yun: Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/memory/1616063020?i=1616063035' WHERE id = 34318 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34318 Memory (spotify: Isang Yun: Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0Swkk0HhnKvmV7gMNRDPKW' WHERE id = 34318 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34319 Teile dich Nacht (apple: Isang Yun: Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/teile-dich-nacht/1616063020?i=1616063037' WHERE id = 34319 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34319 Teile dich Nacht (spotify: Isang Yun: Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1cCRXS5zs745UQO5c6kFzT' WHERE id = 34319 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34320 Bara (apple: Isang Yun: Works, Vol. 3 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/bara-live/1618775374?i=1618775436' WHERE id = 34320 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34320 Bara (spotify: Isang Yun: Works, Vol. 3 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/08bnm7UVFZhXxHSkm44Cfs' WHERE id = 34320 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34321 Symphonische Szene (apple: Isang Yun: Works, Vol. 8 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/symphonische-szene/1624566536?i=1624566636' WHERE id = 34321 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34321 Symphonische Szene (spotify: Isang Yun: Works, Vol. 8 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/23sAkWtQPrpr5qtMyMzILw' WHERE id = 34321 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34325 Konzertante Figuren (apple: Isang Yun: Works, Vol. 8 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/konzertante-figuren-live/1624566536?i=1624566637' WHERE id = 34325 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34325 Konzertante Figuren (spotify: Isang Yun: Works, Vol. 8 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0i8VdcXJzrYvxSGKakClMu' WHERE id = 34325 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34326 Ouverture (apple: Isang Yun: Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ouverture-for-orchestra/1616063020?i=1616063024' WHERE id = 34326 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34326 Ouverture (spotify: Isang Yun: Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2cHcIA390REVSazL5LTmxa' WHERE id = 34326 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34327 Harmonia (apple: Yun: 20th Century Portraits)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/harmonia/321686505?i=321686821' WHERE id = 34327 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34327 Harmonia (spotify: Yun, I.: Reak / Cello Concerto / Harmonia (10Th Century Portraits))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1sh5lYMtLUzCdLHingZWlb' WHERE id = 34327 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34328 Muak (apple: Isang Yun: Muak - Pièce concertante)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/muak-t%C3%A4nzerische-fantasie-f%C3%BCr-grosses-orchester-1978/1189229730?i=1189230020' WHERE id = 34328 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34328 Muak (spotify: Isang Yun: Works, Vol. 5 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1cbvyFVDFlVnT7ifmcnFgl' WHERE id = 34328 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34329 Fanfare & Memorial (apple: Isang Yun - Sunrise Falling)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/fanfare-memorial/1795129162?i=1795129167' WHERE id = 34329 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34329 Fanfare & Memorial (spotify: Isang Yun - Sunrise Falling)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3kBWAczV8zOtSevYQ5qdEl' WHERE id = 34329 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34330 Exemplum in memoriam Kwangju (spotify: Yun: My Land, My People! / Exemplum in Memoriam Kwangju)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/36msC0Tg2FnWDZ71a9SFre' WHERE id = 34330 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34331 Symphony No. 1 (apple: Yun: Symphonies Nos. 1 and 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/yun-symphonies-nos-1-and-3/599988477' WHERE id = 34331 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34331 Symphony No. 1 (spotify: Isang Yun: Loyang Symphony No. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1rvf68nhpk8S9d0LqlP8GA' WHERE id = 34331 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34332 Symphony No. 2 (apple: Yun: Symphonies Nos. 2 and 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/yun-symphonies-nos-2-and-4/600075640' WHERE id = 34332 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34332 Symphony No. 2 (spotify: Yun: Symphonies Nos. 2 and 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1QUTiXDE3u0p8JzbVvtmCb' WHERE id = 34332 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34333 Symphony No. 3 (apple: Yun: Symphonies Nos. 1 and 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/symphony-no-3/599988477?i=599988486' WHERE id = 34333 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34333 Symphony No. 3 (spotify: Yun: Symphonies Nos. 1 and 3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1yXfRRtZj2I03s65CxOF1E' WHERE id = 34333 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34334 Symphony No. 4 "Im Dunkeln singen" (spotify: Yun: Symphonies Nos. 2 and 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1QUTiXDE3u0p8JzbVvtmCb' WHERE id = 34334 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34335 Symphony No. 5 (apple: Yun: Symphony No. 5)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/yun-symphony-no-5/600075815' WHERE id = 34335 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34335 Symphony No. 5 (spotify: Yun: Symphony No. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0pSYZ1WjWhwnTgCrSJYVsu' WHERE id = 34335 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34337 Tapis pour cordes (apple: Yun: Chamber Symphony I - Tapis pour corses - Gong-Hu for harp and strings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/tapis-pour-cordes/121310450?i=121310440' WHERE id = 34337 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34337 Tapis pour cordes (spotify: Isang Yun: Pièce concertante / Streichquartett V / Pezzo fantasioso / Tapis / Teile Dich Nacht)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1GnHDtOjOAitq7EtXO7SBL' WHERE id = 34337 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34338 Chamber Symphony No. 1 (apple: Yun: Chamber Symphony I - Tapis pour corses - Gong-Hu for harp and strings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/chamber-symphony-i/121310450?i=121310423' WHERE id = 34338 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34338 Chamber Symphony No. 1 (spotify: Yun: Chamber Symphony I / Tapis / Gong-Hu)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/75YvicaUpbhVnEOXz1evvF' WHERE id = 34338 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34339 Chamber Symphony No. 2 "Den Opfern der Freiheit" (apple: Isang Yun: Works, Vol. 10)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-works-vol-10/1624933186' WHERE id = 34339 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34339 Chamber Symphony No. 2 "Den Opfern der Freiheit" (spotify: Isang Yun: Works, Vol. 10)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6LkGkUC1JfA2aCDix3MWpN' WHERE id = 34339 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34341 Silla (spotify: Yun: Three Late Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2GH4tlQbPLTSNoV3k3BNY6' WHERE id = 34341 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34342 Engel in Flammen (apple: Isang Yun: Works, Vol. 11)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/engel-in-flammen/1626498174?i=1626498440' WHERE id = 34342 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34342 Engel in Flammen (spotify: Isang Yun: Works, Vol. 11)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6YNP263VDnkm5xzm9umoRw' WHERE id = 34342 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34343 Flute Concerto (spotify: Isang Yun: Gong Hu - Salomo - Flute Concerto & In Balance)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/09yLl8F2PO00OUfjuq2gnW' WHERE id = 34343 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34344 Double Concerto for Oboe and Harp (apple: Isang Yun: Double Concerto & Images)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/double-concerto-for-oboe-and-harp-with-small-orchestra/1190388746?i=1190388749' WHERE id = 34344 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34344 Double Concerto for Oboe and Harp (spotify: Isang Yun: Double Concerto & Images)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1ut3vfzYEMiyYNIDHwlOBE' WHERE id = 34344 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34345 Violin Concerto No. 1 (apple: Isang Yun - Sunrise Falling)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-sunrise-falling/1795129162' WHERE id = 34345 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34345 Violin Concerto No. 1 (spotify: Isang Yun - Sunrise Falling)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6lKpX4lHYKJsIyTQc1ylJh' WHERE id = 34345 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34347 Gong-Hu (apple: Yun: Chamber Symphony I - Tapis pour corses - Gong-Hu for harp and strings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/gong-hu-for-harp-and-strings/121310450?i=121310444' WHERE id = 34347 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34347 Gong-Hu (spotify: Yun: Chamber Symphony I / Tapis / Gong-Hu)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0k1aErXnBSsHulPjPEqdZT' WHERE id = 34347 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34350 Oboe Concerto (apple: Isang Yun: Works, Vol. 10)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-works-vol-10/1624933186' WHERE id = 34350 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34350 Oboe Concerto (spotify: Isang Yun: Works, Vol. 10)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6LkGkUC1JfA2aCDix3MWpN' WHERE id = 34350 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34353 Loyang (apple: Yun: Loyang / Gasa / Réak / Shao Yang Yin / Tuyaux sonores)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/loyang-f%C3%BCr-kammerensemble/1704634992?i=1704635420' WHERE id = 34353 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34353 Loyang (spotify: Isang Yun: Loyang Symphony No. 1)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1rvf68nhpk8S9d0LqlP8GA' WHERE id = 34353 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34354 Pièce concertante (apple: Isang Yun: Muak - Pièce concertante)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/pi%C3%A8ce-concertante-f%C3%BCr-kammer-ensemble-oder-kleines/1189229730?i=1189230287' WHERE id = 34354 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34354 Pièce concertante (spotify: Isang Yun: Muak - Pièce concertante)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3X9MNgr2qxEQKMZyh6ioiF' WHERE id = 34354 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34355 Octet (spotify: The First Beauty)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0tseaV1BZMS3XGNFqafQ31' WHERE id = 34355 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34360 Clarinet Quintet No. 1 (spotify: Brahms & Yun: Clarinet Quintets)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4pjoxiBkEJfEgLuX9UWfTr' WHERE id = 34360 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34362 Clarinet Quintet No. 2 (apple: Isang Yun: Clarinet Quintet Nos. 1 & 2, String Quartet No. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-clarinet-quintet-nos-1-2-string-quartet-no-6/684471672' WHERE id = 34362 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34362 Clarinet Quintet No. 2 (spotify: Isang Yun: Works, Vol. 6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5422jzNUBKvkek4GQlCavv' WHERE id = 34362 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34363 String Quartet No. 1 (apple: Beethoven: String Quartet No. 11 "Serioso" / Yun: String Quartet No. 1 / Webern: Langsamer Satz)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/beethoven-string-quartet-no-11-serioso-yun-string-quartet-no-1-webern-langsamer-satz/1675255690' WHERE id = 34363 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34363 String Quartet No. 1 (spotify: Beethoven: String Quartet No. 11 "Serioso" / Yun: String Quartet No. 1 / Webern: Langsamer Satz)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6kg41DF5iSTx0eq202lmVW' WHERE id = 34363 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34364 String Quartet No. 3 (apple: Isang Yun: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-chamber-music/681206854' WHERE id = 34364 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34364 String Quartet No. 3 (spotify: Isang Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7ngSYN632EbtXCupVtHlZ2' WHERE id = 34364 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34365 Images (apple: Isang Yun: Double Concerto & Images)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/images-for-flute-oboe-violin-and-violoncello/1190388746?i=1190388752' WHERE id = 34365 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34365 Images (spotify: Isang Yun: Double Concerto & Images)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0Z0ElHZpBOwifYVfSnPrPp' WHERE id = 34365 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34366 Novellette (apple: Yun: Chamber Music - Novelette, Piano Trio, Duo for Cello and Harp & Violin Sonata)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/novellette/314303446?i=314303512' WHERE id = 34366 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34366 Novellette (spotify: Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3JrL1asLPeLuWi5H1Pk0RF' WHERE id = 34366 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34368 String Quartet No. 4 (apple: Isang Yun: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-chamber-music/681206854' WHERE id = 34368 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34368 String Quartet No. 4 (spotify: Isang Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7ngSYN632EbtXCupVtHlZ2' WHERE id = 34368 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34370 String Quartet No. 6 (apple: Isang Yun: Clarinet Quintet Nos. 1 & 2, String Quartet No. 6)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-clarinet-quintet-nos-1-2-string-quartet-no-6/684471672' WHERE id = 34370 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34370 String Quartet No. 6 (spotify: Isang Yun: Clarinet Quintet Nos. 1 & 2, String Quartet No. 6)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3HliNgL9sRxFwcUbBYqPlI' WHERE id = 34370 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34371 Oboe Quartet (apple: Isang Yun: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/oboe-quartet/1450558329?i=1450558337' WHERE id = 34371 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34371 Oboe Quartet (spotify: Isang Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3uG3BKraILhN8xUOqDnGcG' WHERE id = 34371 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34372 Trio for Flute, Oboe and Violin (apple: Yun: Chamber Works (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/trio-for-flute-oboe-violin-live/1613955718?i=1613955719' WHERE id = 34372 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34372 Trio for Flute, Oboe and Violin (spotify: Isang Yun: Trio, Sori, Königliches Thema, Piri & Vier Inventionen)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/57XORDzgdbwmkqALqQmHjy' WHERE id = 34372 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34373 Piano Trio (apple: Yun: Chamber Music - Novelette, Piano Trio, Duo for Cello and Harp & Violin Sonata)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/piano-trio/314303446?i=314303523' WHERE id = 34373 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34373 Piano Trio (spotify: Yun, I.: Chamber Music - Novelette / Piano Trio / Duo for Cello and Harp / Violin Sonata)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3iJpPrb5BLLMDEBzHAqn7Z' WHERE id = 34373 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34374 Rondell (apple: Yun: Music for Wind)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/rondell/681243443?i=681243933' WHERE id = 34374 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34374 Rondell (spotify: Yun: Music for Wind)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1Dvyx6zsigGgbK1zxVAwTM' WHERE id = 34374 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34376 Rencontre (apple: Isang Yun: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/rencontre/1450558329?i=1450558333' WHERE id = 34376 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34376 Rencontre (spotify: Isang Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3S4492rcMtvjkA4Qg2lAQS' WHERE id = 34376 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34377 Gasa for Violin and Piano (apple: Isang Yun - Sunrise Falling)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/gasa-for-violin-and-piano/1795129162?i=1795129170' WHERE id = 34377 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34377 Gasa for Violin and Piano (spotify: Isang Yun - Sunrise Falling)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/61SCTpiZaeJhoB5D6dr3Qn' WHERE id = 34377 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34378 Garak for Flute and Piano (apple: Isang Yun: Works, Vol. 7 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/garak-for-flute-piano-live/1623385489?i=1623385490' WHERE id = 34378 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34378 Garak for Flute and Piano (spotify: Crossroads 2022: Contemporary Music Days in Armenia (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1peAvPbZk160GXtWRy5kS1' WHERE id = 34378 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34379 Nore for Cello and Piano (apple: Isang Yun und das Cello)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/nore-f%C3%BCr-violoncello-und-klavier-1964-rev-1968/1836117168?i=1836117169' WHERE id = 34379 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34381 Duo for Viola and Piano (apple: Isang Yun: Works, Vol. 7 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/duo-for-viola-piano-live/1623385489?i=1623385505' WHERE id = 34381 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34381 Duo for Viola and Piano (spotify: Pierce Plays Microtonal Masterpieces by Cage, Hovhannes, Ives, Ohana, Penderecki, Schoenberg, Stahnke, Wyschnegradsky, Yun and More (Live Recording))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0q6ruwe3gIfeqDZiiVFcQN' WHERE id = 34381 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34383 Violin Sonata (apple: Yun: Chamber Music - Novelette, Piano Trio, Duo for Cello and Harp & Violin Sonata)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/violin-sonata/314303446?i=314303575' WHERE id = 34383 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34383 Violin Sonata (spotify: Yun, I.: Chamber Music - Novelette / Piano Trio / Duo for Cello and Harp / Violin Sonata)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2qHtwQ3MPQnzZZt90at1tO' WHERE id = 34383 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34384 Espace I (apple: Mit Myrten und Rosen - Schumann & Yun: Complete Works for Cello & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/espace-i/553792041?i=553792074' WHERE id = 34384 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34384 Espace I (spotify: Toshio Hosokawa / J.S. Bach / Isang Yun)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/614hdJ0SHu1IyQv1i47PIX' WHERE id = 34384 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34386 Shao Yang Yin (apple: Yun: Loyang / Gasa / Réak / Shao Yang Yin / Tuyaux sonores)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/shao-yang-yin-f%C3%BCr-cembalo/1704634992?i=1704635722' WHERE id = 34386 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34386 Shao Yang Yin (spotify: Yun: Loyang / Gasa / Réak / Shao Yang Yin / Tuyaux sonores)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2KZZI6l5Twx90xxRawWmcY' WHERE id = 34386 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34387 Tuyaux sonores (apple: Yun: Loyang / Gasa / Réak / Shao Yang Yin / Tuyaux sonores)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/tuyaux-sonores-f%C3%BCr-orgel/1704634992?i=1704635736' WHERE id = 34387 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34387 Tuyaux sonores (spotify: Yun: Loyang / Gasa / Réak / Shao Yang Yin / Tuyaux sonores)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4qaEZPfjxstIFQBdD3JfPG' WHERE id = 34387 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34388 Glissées (apple: Premiere Recordings)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/premiere-recordings/1575602560' WHERE id = 34388 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34388 Glissées (spotify: Alfons & Aloys Kontarsky: Webern – Zimmermann)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4tg8IDipJQXrWnwUsLbdM7' WHERE id = 34388 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34389 Piri (apple: Isang Yun: Works, Vol. 4)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/piri/1619516998?i=1619517002' WHERE id = 34389 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34389 Piri (spotify: Karura: Works for Oboe Solo)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4GkPoUGfOPXY0emRyGqiul' WHERE id = 34389 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34390 Königliches Thema (apple: Isang Yun: Complete Works for Violin Solo and With Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/k%C3%B6nigliches-thema-1976-for-violin/1778668768?i=1778668773' WHERE id = 34390 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34390 Königliches Thema (spotify: Isang Yun: Trio, Sori, Königliches Thema, Piri & Vier Inventionen)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1LY69mwqefzxslCK0WxBOu' WHERE id = 34390 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34391 Salomo (spotify: Isang Yun: Gong Hu - Salomo - Flute Concerto & In Balance)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5NcI7JtaR70aBC1ecGsQvG' WHERE id = 34391 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34392 Interludium A (apple: Isang Yun - Sunrise Falling)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/interludium-a/1795129162?i=1795129164' WHERE id = 34392 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34392 Interludium A (spotify: Isang Yun - Sunrise Falling)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0GVoraefgPSOLDznV3j3sg' WHERE id = 34392 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34393 Li-Na im Garten (apple: Earl Kim & Isang Yun: Complete Works for Solo Violin)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/earl-kim-isang-yun-complete-works-for-solo-violin/1593678196' WHERE id = 34393 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34393 Li-Na im Garten (spotify: Works for Violin Solo - Isang Yun / Schnittke / Bartók / J.S.Bach)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6WHaOsfkpd66ACtd2zfj2L' WHERE id = 34393 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34394 In Balance (spotify: Isang Yun: Gong Hu - Salomo - Flute Concerto & In Balance)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0h5zY3bXTqNoPQVmk5hkgE' WHERE id = 34394 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34395 Kontraste (apple: Isang Yun: Complete Works for Violin Solo and With Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-complete-works-for-violin-solo-and-with-piano/1778668768' WHERE id = 34395 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34395 Kontraste (spotify: Earl Kim & Isang Yun: Complete Works for Solo Violin)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6jc7x0PwdJMHNydtx2drOS' WHERE id = 34395 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 34396 Sori (apple: Yun: Music for Wind)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/sori/681243443?i=681244050' WHERE id = 34396 AND composer_id = 90 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34396 Sori (spotify: Yun: Chamber Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3BsXAJA8eY5FMM9tW3aWyR' WHERE id = 34396 AND composer_id = 90 AND (spotify_url IS NULL OR spotify_url = '');
-- 388 Gagok <Gagopa> (apple: 한국가곡집 제3집 골든애창곡)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B0%80%EA%B3%A0%ED%8C%8C/1633857731?i=1633857834' WHERE id = 388 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 388 Gagok <Gagopa> (spotify: 한국 애창가곡 4집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3dHu3fNjArf6nw6w9cvzTb' WHERE id = 388 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 389 Gagok <Magnolia (Mongnyeonhwa)> (apple: 김동진 예술가곡집 (가고파 / 목련화))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EB%AA%A9%EB%A0%A8%ED%99%94/1746922365?i=1746922641' WHERE id = 389 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 389 Gagok <Magnolia (Mongnyeonhwa)> (spotify: 한국 애창가곡 4집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4KrqHdDdGgytu8fM5aiTKg' WHERE id = 389 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 390 Gagok <My Heart (Nae Maeum)> (apple: 김동진 예술가곡집 (가고파 / 목련화))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EB%82%B4-%EB%A7%88%EC%9D%8C/1746922365?i=1746922639' WHERE id = 390 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 390 Gagok <My Heart (Nae Maeum)> (spotify: 한국애창가곡3)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6cCE8tqmv2y4qg4NsShr8L' WHERE id = 390 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 460 Sin-Arirang (New Arirang) (apple: Korean Lyric Song Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/new-arirang/1592912640?i=1592912642' WHERE id = 460 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 460 Sin-Arirang (New Arirang) (spotify: Soprano Cho Kyung-hwa Solo Recital Live)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5rPhTETWJtwm759rA7TnFa' WHERE id = 460 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 34423 Gagok <When Spring Comes (Bomi Omyeon)> (spotify: 한국가곡 바리톤 유승공)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/62yzf4X4vNu0xbNS3ab31x' WHERE id = 34423 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 34424 Gagok <Gagopa, Part 2 (Gagopa Hupyeon)> (apple: 김동진 예술가곡집 (가고파 / 목련화))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B0%80%EA%B3%A0%ED%8C%8C-%EC%A0%84%ED%8E%B8-%ED%9B%84%ED%8E%B8/1746922365?i=1746922367' WHERE id = 34424 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34424 Gagok <Gagopa, Part 2 (Gagopa Hupyeon)> (spotify: 김동진 예술가곡집(가고파/목련화))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3cMym63Apdg2WSKr3z4vkc' WHERE id = 34424 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 34425 Gagok <Narcissus (Suseonhwa)> (spotify: 한국 애창가곡 3집)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2VPPTtRr3S2i8MAPoVIbF4' WHERE id = 34425 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 34426 Gagok <Azaleas (Jindallaekkot)> (apple: 김동진 예술가곡집 (가고파 / 목련화))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EC%A7%84%EB%8B%AC%EB%9E%98%EA%BD%83/1746922365?i=1746922640' WHERE id = 34426 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34426 Gagok <Azaleas (Jindallaekkot)> (spotify: 김동진 예술가곡집(가고파/목련화))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2Ca54hph7EpDq265zXpRQJ' WHERE id = 34426 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 34428 Gagok <Where the Clouds Drift (Jeo Gureum Heulleoganeun Got)> (apple: 김동진 예술가곡집 (가고파 / 목련화))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EC%A0%80-%EA%B5%AC%EB%A6%84-%ED%9D%98%EB%9F%AC%EA%B0%80%EB%8A%94-%EA%B3%B3/1746922365?i=1746922368' WHERE id = 34428 AND composer_id = 103 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34428 Gagok <Where the Clouds Drift (Jeo Gureum Heulleoganeun Got)> (spotify: 김동진 예술가곡집(가고파/목련화))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/234dGA5BPDZOiYlL3XA1lP' WHERE id = 34428 AND composer_id = 103 AND (spotify_url IS NULL OR spotify_url = '');
-- 26025 Symphonic Poem <Also sprach Zarathustra> (spotify: Strauss, R.: Also sprach Zarathustra; Till Eulenspiegel; Don Juan; Salome's Dance Of The Seven Veils)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1kHbPoLRmiAHIDgYRraYU9' WHERE id = 26025 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33751 Aus Italien (apple: Richard Strauss: Aus Italien - Don Juan)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-aus-italien-don-juan/1452609173' WHERE id = 33751 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33751 Aus Italien (spotify: Richard Strauss: Aus Italien; Don Juan)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2MKhGr6SrkRK4DEP827hjZ' WHERE id = 33751 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33752 Don Juan (spotify: Strauss, R.: Also sprach Zarathustra; Till Eulenspiegel; Don Juan; Salome's Dance Of The Seven Veils)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2VE6SDB4WRJpeL56uFx3IM' WHERE id = 33752 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33753 Macbeth (apple: Strauss: Alpensinfonie & Macbeth)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/macbeth-op-23/1749360640?i=1749361078' WHERE id = 33753 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33753 Macbeth (spotify: R. Strauss: Sinfonia domestica; Macbeth)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/5U6OkVyCD2repiBKz7IXwv' WHERE id = 33753 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33754 Tod und Verklärung, op. 24 (apple: Richard Strauss: Also sprach Zarathustra, Tod und Verklärung, Till Eulenspiegel, Salome's Dance (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-also-sprach-zarathustra-tod-und-verklarung-till-eulenspiegel-salome-s-dance-live/1474614475' WHERE id = 33754 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33754 Tod und Verklärung, op. 24 (spotify: Strauss: Also sprach Zarathustra, Op. 30, TrV 176 & Tod und Verklärung, Op. 24, TrV 158)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/68XJ592DSyri5mjZXUyJE7' WHERE id = 33754 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33755 Till Eulenspiegels lustige Streiche (spotify: Strauss: Also sprach Zarathustra, Op. 30 & Till Eulenspiegels lustige Streiche, Op. 28 & Don Juan, Op. 20)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2uWOAO8mP01bjfmRqzyjhd' WHERE id = 33755 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33756 Don Quixote (apple: R. Strauss: Don Quixote – Ravel: Boléro)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-don-quixote-ravel-bolero/1480825874' WHERE id = 33756 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33756 Don Quixote (spotify: Strauss: Don Quixote, Don Juan)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0n911XBhxYQozi6INHdg3e' WHERE id = 33756 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33757 Ein Heldenleben (apple: Strauss: Ein Heldenleben, Op. 40, TrV 190 - Wagner: Siegfried-Idyll, WWV 103)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-ein-heldenleben-op-40-trv-190-wagner-siegfried-idyll-wwv-103/1452283710' WHERE id = 33757 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33757 Ein Heldenleben (spotify: Strauss, R.: Ein Heldenleben / Wagner: Siegfried-Idyll)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2DH8bdmqZPBd0xq55wqXJs' WHERE id = 33757 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33758 Symphonia Domestica (apple: Strauss: Symphonia domestica - Die Liebe der Danae: Symphonic Fragment)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-symphonia-domestica-die-liebe-der-danae-symphonic-fragment/553033973' WHERE id = 33758 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33758 Symphonia Domestica (spotify: Strauss: Sinfonia domestica, Op. 53 & Till Eulenspiegel's Merry Pranks, Op. 28)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6LT9pIwHhRymNoqtVwtKNT' WHERE id = 33758 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33759 Eine Alpensinfonie (apple: Strauss: Eine Alpensinfonie)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-eine-alpensinfonie/1769629575' WHERE id = 33759 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33759 Eine Alpensinfonie (spotify: Strauss, R.: An Alpine Symphony Op.64)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4U5v1gQrlbbZgy5Gt8DOVY' WHERE id = 33759 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33760 Metamorphosen, study for 23 solo strings (apple: Shostakovich: Chamber Symphony, Op. 110a - Strauss: Metamorphosen for 23 Strings, TrV 290)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/metamorphosen-for-23-solo-strings-trv-290/1250894762?i=1250895405' WHERE id = 33760 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33760 Metamorphosen, study for 23 solo strings (spotify: Strauss, R.: Metamorphosen; Tod und Verklärung)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3bosps66VSL1MIIgbHmvcP' WHERE id = 33760 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33761 Festliches Präludium (apple: Richard Strauss: Eine Alpensinfonie, Festliches Präludium)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/festliches-pr%C3%A4ludium-op-61/380155372?i=380155599' WHERE id = 33761 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33761 Festliches Präludium (spotify: Richard Strauss: Eine Alpensinfonie; Festliches Präludium)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2fUZbUnwHaYVyGxM6IvlOe' WHERE id = 33761 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33762 Japanische Festmusik (apple: Richard Strauss Dirigiert Richard Strauss)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/japanische-festmusik-op-84-festive-music-in-celebration/1452726114?i=1452726280' WHERE id = 33762 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33762 Japanische Festmusik (spotify: The Great Conductors, Vol. 2: Richard Strauss (Japanische Festmusik & Symphonic Poems))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/2KK74cu0sfoQU1IWp6mdY3' WHERE id = 33762 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33763 Der Bürger als Edelmann (apple: Strauss: Der Rosenkavalier Suite & Der Bürger Als Edelmann Suite, Op. 60)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-der-rosenkavalier-suite-der-burger-als-edelmann-suite-op-60/263184093' WHERE id = 33763 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33763 Der Bürger als Edelmann (spotify: Strauss: Der Bürger als Edelmann & Metamorphosen)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4MA0nZ8x3j95OLzcYXHIEp' WHERE id = 33763 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33764 Serenade for 13 Wind Instruments in E-flat major (apple: Richard Strauss: Don Quixote; Romanze; Serenade, Op. 7)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/serenade-for-13-wind-instruments-in-e-flat-major-op-7/358320347?i=358321588' WHERE id = 33764 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33764 Serenade for 13 Wind Instruments in E-flat major (spotify: Richard Strauss Wind Music)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/0Qxr1W72b6THIDAfFP7hnv' WHERE id = 33764 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33765 Suite for 13 wind instruments in B-flat major (apple: R. Strauss: Sonatina No. 1 'From an Invalid's Workshop'; Suite for 13 Wind Instruments (Netherlands Wind Ensemble: Complete Philips Recordings, Vol. 13))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-sonatina-no-1-from-an-invalid-s-workshop-suite-for-13-wind-instruments-netherlands-wind-ensemble-complete-philips-recordings-vol-13/1621629982' WHERE id = 33765 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33765 Suite for 13 wind instruments in B-flat major (spotify: Richard Strauss: Suite for 13 Wind Instruments; Symphony for Wind Instruments; Serenade)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6p9JYMNGzw5DjN5K1hYfCc' WHERE id = 33765 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33766 Sonatina no. 1 in F major “From the Workshop of an Invalid” (apple: Strauss: Metamorphosen & Wind Sonatina No. 1)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-metamorphosen-wind-sonatina-no-1/1704656510' WHERE id = 33766 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33766 Sonatina no. 1 in F major “From the Workshop of an Invalid” (spotify: Strauss: Sonatina No. 1 in F Major for 16 Wind Instruments, TrV 288 "From the Workshop of an Invalid")
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2MiyudcEchlK6hUFpgdmod' WHERE id = 33766 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33767 Sonatina no. 2 in E-flat major “Fröhliche Werkstatt” (apple: Richard Strauss: Sonatine No. 2 in E-Flat Major, TrV 291 "Happy Workshop" & Serenade for Winds in E-Flat Major, Op. 7, TrV 106)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-sonatine-no-2-in-e-flat-major-trv-291-happy-workshop-serenade-for-winds-in-e-flat-major-op-7-trv-106/1606025823' WHERE id = 33767 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33767 Sonatina no. 2 in E-flat major “Fröhliche Werkstatt” (spotify: R. Strauss: Sonatina No. 2, TrV 291 "Fröhliche Werkstatt")
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5ZbnwCHm5QN3OnA0Ta5BY0' WHERE id = 33767 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33768 Divertimento, op. 86 (apple: R. Strauss: Tanzsuite & Divertimento aus Klavierstücken von François Couperin)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-tanzsuite-divertimento-aus-klavierstucken-von-francois-couperin/1535644050' WHERE id = 33768 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33768 Divertimento, op. 86 (spotify: R. Strauss: Divertimento; Le bourgeois gentilhomme Suite)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2T5CxE4X4KzR06VtzxGRyX' WHERE id = 33768 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33769 Tanzsuite aus Klavierstücken von François Couperin (apple: Richard Strauss: Le bourgeois gentilhomme Suite & Couperin Suite)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-le-bourgeois-gentilhomme-suite-couperin-suite/1452659232' WHERE id = 33769 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33769 Tanzsuite aus Klavierstücken von François Couperin (spotify: Treasures of World Music Performed by Dmitri Kitayenko)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0FP74WcI78NDm1bjQwUvHX' WHERE id = 33769 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33770 2 Militärmärsche für großes Orchester (apple: R. Strauss: Music for Wind Instruments)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-music-for-wind-instruments/1315737326' WHERE id = 33770 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33772 Symphony no. 2 in F minor (apple: R. Strauss: Symphony No. 2 in F Minor, Op. 12, TrV 126 & Concert Overture in C Minor, TrV 125)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-symphony-no-2-in-f-minor-op-12-trv-126-concert-overture-in-c-minor-trv-125/1498081724' WHERE id = 33772 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33772 Symphony no. 2 in F minor (spotify: R. Strauss: Symphony No. 2 in F Minor, Op. 12, TrV 126 & Concert Overture in C Minor, TrV 125)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3QTdSwn7lPLx44zW4PVsRZ' WHERE id = 33772 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33773 Violin Concerto in D minor (apple: Strauss: Violin Concerto - Sonata)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-violin-concerto-sonata/723743759' WHERE id = 33773 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33773 Violin Concerto in D minor (spotify: Strauss & Bartók: Violin Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3zCSqBTsOuqrqOMRE5naEq' WHERE id = 33773 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33774 Waldhornkonzert Es-Dur nr. 1 (apple: Beethoven: Symphony No. 3, Op. 55 "Eroica" - Strauss: Horn Concerto No. 1, Op. 11 (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/beethoven-symphony-no-3-op-55-eroica-strauss-horn-concerto-no-1-op-11-live/1436349386' WHERE id = 33774 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33774 Waldhornkonzert Es-Dur nr. 1 (spotify: Strauss, R.: Horn Concertos Nos. 1 & 2; Duet Concertino; Oboe Concerto)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3gHbwLZKL47LqNoLPpNk7J' WHERE id = 33774 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33775 Konzert für Horn und Orchester Nr. 2 Es-Dur, AV 132 (spotify: Works for Horn & Orchestra)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3bDK2HGABZSvxqPEqLnJX5' WHERE id = 33775 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33776 Oboe Concerto in D major, TrV 292, AV 144 (apple: R. Strauss: Oboe Concerto, TrV 292, Horn Concerto No. 1, TrV 117 & Der Bürger als Edelmann Suite, TrV 228c)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-oboe-concerto-trv-292-horn-concerto-no-1-trv-117-der-burger-als-edelmann-suite-trv-228c/1712752571' WHERE id = 33776 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33776 Oboe Concerto in D major, TrV 292, AV 144 (spotify: Strauss, R.: Four Last Songs; Metamorphoses; Oboe Concerto)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/53sZLNqeX5T2e8BwmoOQe4' WHERE id = 33776 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33777 Burleske in D minor, TrV 145 (apple: Berlioz: Symphonie fantastique, Op. 14, H 48 & Strauss: Burleske for Piano and Orchestra in D Minor, TrV 145)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/berlioz-symphonie-fantastique-op-14-h-48-strauss-burleske-for-piano-and-orchestra-in-d-minor-trv-145/1258302558' WHERE id = 33777 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33777 Burleske in D minor, TrV 145 (spotify: Strauss: Symphonia Domestica & Burleske)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4SqTN2ZcPmOSsjmwzE7yHQ' WHERE id = 33777 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33778 Duett-Concertino for Clarinet, Bassoon and Strings (apple: Strauss: Der Bürger als Edelmann Suite, Op. 60b, TrV 228c & Duett-Concertino, TrV 293)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-der-burger-als-edelmann-suite-op-60b-trv-228c-duett-concertino-trv-293/1064284930' WHERE id = 33778 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33778 Duett-Concertino for Clarinet, Bassoon and Strings (spotify: Strauss: Der Bürger als Edelmann Suite, Op. 60b, TrV 228c & Duett-Concertino, TrV 293)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/25YIZDNU94TkJ47T6B83cV' WHERE id = 33778 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33779 Panathenäenzug (apple: Strauss: Violin Concerto, Op. 8, Burleske for Piano and Orchestra & Panathenäenzug, Op. 74)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/panathen%C3%A4enzug-symphonic-studies-in-the-form/1473493640?i=1473493886' WHERE id = 33779 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33779 Panathenäenzug (spotify: Strauss: Piano Concertos for the Left Hand)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0FfnRuQskvU2dAkFuixRtj' WHERE id = 33779 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33780 Romanze in F major for Violoncello & Orchestra, AV 75 (apple: Strauss & Mendelssohn: Cello Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/romance-in-f-major-av75/888368297?i=888368312' WHERE id = 33780 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33780 Romanze in F major for Violoncello & Orchestra, AV 75 (spotify: Richard Strauss: Don Quixote; Romanze; Serenade, Op. 7)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4Rs6OqCW9liOTmGoFZQYWZ' WHERE id = 33780 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33781 String Quartet in A major (apple: Strauss: String Quartet in A Major - Kreisler: String Quartet in A Minor)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-string-quartet-in-a-major-kreisler-string-quartet-in-a-minor/277012644' WHERE id = 33781 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33781 String Quartet in A major (spotify: Strauss, Puccini & Verdi: Works for String Quartet)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/69Jh4zuEtzb6KPqDAkLU87' WHERE id = 33781 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33782 Cello Sonata in F major (apple: Strauss: Cello Sonata, Op. 6 - Beethoven: 12 Variations for Cello and Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-cello-sonata-op-6-beethoven-12-variations-for-cello-and-piano/691885121' WHERE id = 33782 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33782 Cello Sonata in F major (spotify: Strauss: Cello Sonata, Op. 6, TrV 115 – Honegger: Sonata for Cello & Piano, H 32 - Sonatina for Cello & Piano, H 42)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3WnLr5ocaYftxARxGgjPuF' WHERE id = 33782 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33783 Piano Quartet in C minor (apple: Strauss: Piano Quartet, Op. 13 - Metamorphosen for String Septet (Live))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-quartet-op-13-metamorphosen-for-string-septet-live/1732992539' WHERE id = 33783 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33783 Piano Quartet in C minor (spotify: Strauss: Piano Quartet in C Major, Op. 13, TrV 137 & Piano Trio No. 2 in D Major, TrV 71)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6ud7ALaMEKPRC6sGg5bpKg' WHERE id = 33783 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33784 Sonata for Violin and Piano in E-flat major (apple: Strauss: Sonata for Violin and Piano - Dvořák: 4 Romantic Pieces for Violin and Piano - Kreisler: Schön Rosmarin, Liebesleid, Syncopation)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-sonata-for-violin-and-piano-dvorak-4-romantic-pieces-for-violin-and-piano-kreisler-schon-rosmarin-liebesleid-syncopation/1452238361' WHERE id = 33784 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33784 Sonata for Violin and Piano in E-flat major (spotify: Strauss: Sonata for Violin and Piano Op. 18 / Dvorak: Romantic Pieces for Violin and Piano Op. 75 / Kreisler: Schön Rosmarin; Liebesleid; Syncopation; Marche miniature viennoise)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5Uz9Hr7RgU1snaEjRKOyXu' WHERE id = 33784 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33785 Piano Trio no. 1 in A major (apple: Strauss: Piano Trios and Piano Quartets)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-trios-and-piano-quartets/365028933' WHERE id = 33785 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33785 Piano Trio no. 1 in A major (spotify: Strauss, R.: Piano Trios Nos. 1 and 2)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6pH7Qg5SLKKHpjWDzFMkRh' WHERE id = 33785 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33786 Piano Trio no. 2 in D major, for violin, cello and piano (apple: Strauss: Piano Quartet in C Major, Op. 13, TrV 137 & Piano Trio No. 2 in D Major, TrV 71)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-quartet-in-c-major-op-13-trv-137-piano-trio-no-2-in-d-major-trv-71/1438911303' WHERE id = 33786 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33786 Piano Trio no. 2 in D major, for violin, cello and piano (spotify: Strauss: Piano Quartet in C Major, Op. 13, TrV 137 & Piano Trio No. 2 in D Major, TrV 71)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6ud7ALaMEKPRC6sGg5bpKg' WHERE id = 33786 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33787 Sonata for Piano in B minor, op. 5 (apple: Strauss: Piano Sonata, Op. 5 & Fünf Klavierstücke, Op. 3 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-sonata-op-5-funf-klavierstucke-op-3-gould-remastered/1016534021' WHERE id = 33787 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33787 Sonata for Piano in B minor, op. 5 (spotify: Strauss: Piano Sonata, Op. 5 & Fünf Klavierstücke, Op. 3 (Gould Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4t60UOycp0yw2CpNhyWO6s' WHERE id = 33787 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33788 Klavierstücke (apple: Strauss: Piano Sonata, Op. 5 & Fünf Klavierstücke, Op. 3 - Gould Remastered)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-sonata-op-5-funf-klavierstucke-op-3-gould-remastered/1016534021' WHERE id = 33788 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33788 Klavierstücke (spotify: Strauss: Piano Sonata, Op. 5 & Fünf Klavierstücke, Op. 3 (Gould Remastered))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4t60UOycp0yw2CpNhyWO6s' WHERE id = 33788 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33789 Stimmungsbilder, op. 9 (apple: Strauss: Piano Sonata, 5 Piano Pieces & Stimmungsbilder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-piano-sonata-5-piano-pieces-stimmungsbilder/206600517' WHERE id = 33789 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33789 Stimmungsbilder, op. 9 (spotify: Richard Strauss : Stimmungsbilder, Op. 9 - Modest Mussorgsky : Bilder einer Austellung - Luciano Chailly : Due istantanee, Variazioni nel sogno)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0hdFf8ci8p27g0STU9XP8k' WHERE id = 33789 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33791 Feuersnot, Singgedicht in 1 act (apple: Strauss: Feuersnot, Op. 50, TrV 203)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-feuersnot-op-50-trv-203/957571494' WHERE id = 33791 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33792 Salome (spotify: Richard Strauss: Salome)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1bFdDIXJrbXu7gS1I0pfYV' WHERE id = 33792 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33793 Elektra (apple: Strauss: Elektra, Op. 58, TrV 223)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-elektra-op-58-trv-223/1452297712' WHERE id = 33793 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33793 Elektra (spotify: Strauss, R.: Elektra)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7vHp6VSBJP9TTJ1D74HeAJ' WHERE id = 33793 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33794 Der Rosenkavalier (spotify: Richard Strauss: Der Rosenkavalier)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/40iLWWAkZt2YZO1D6abuMR' WHERE id = 33794 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33795 Ariadne auf Naxos (apple: Strauss: Ariadne Auf Naxos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-ariadne-auf-naxos/1452566823' WHERE id = 33795 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33795 Ariadne auf Naxos (spotify: R. Strauss: Ariadne auf Naxos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0jVGxaIULhu9yChxIikjXy' WHERE id = 33795 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33796 Die Frau ohne Schatten (apple: Richard Strauss: Die Frau ohne Schatten)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-die-frau-ohne-schatten/1452441008' WHERE id = 33796 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33796 Die Frau ohne Schatten (spotify: Strauss, R.: Die Frau ohne Schatten)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6WFnwMf3k81MgKzWqslrCA' WHERE id = 33796 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33797 Intermezzo (apple: Richard Strauss: Intermezzo, Op. 72, TrV 246)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-intermezzo-op-72-trv-246/903466682' WHERE id = 33797 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33797 Intermezzo (spotify: Strauss, R.: Intermezzo op.72)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/52WjO6F2TmgFc1dUEBrKfQ' WHERE id = 33797 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33798 Die ägyptische Helena (apple: Strauss: Die Agyptische Helena)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-die-agyptische-helena/326191473' WHERE id = 33798 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33799 Arabella (apple: Richard Strauss: Arabella)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-arabella/1467907161' WHERE id = 33799 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33799 Arabella (spotify: R. Strauss: Arabella, Op. 79, TrV 263 & 4 Letzte Lieder, TrV 296 (Live))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7KcEheCCM9eYQd1v9ayQSy' WHERE id = 33799 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33800 Die schweigsame Frau (apple: R. Strauss: Die Schweigsame Frau)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-die-schweigsame-frau/692055955' WHERE id = 33800 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33800 Die schweigsame Frau (spotify: Strauss, R: Die Schweigsame Frau)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6tlkCOai0j4rTNgtJuLx4F' WHERE id = 33800 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33801 Friedenstag (apple: Strauss: Friedenstag)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-friedenstag/290338400' WHERE id = 33801 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33801 Friedenstag (spotify: Strauss: Friedenstag, Op. 81, TrV 271 (Recorded Live 1960))
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1XGFPByuOhL2DHHB7YTVCI' WHERE id = 33801 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33802 Daphne (apple: Strauss: Daphne, Op. 82, TrV 272)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-daphne-op-82-trv-272/1447531032' WHERE id = 33802 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33802 Daphne (spotify: R. Strauss: Daphne)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/04lOBXR3IpaqYeYEbx1LF6' WHERE id = 33802 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33803 Die Liebe der Danae (apple: Strauss: Die Liebe der Danae, Op. 83, TrV 278)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-die-liebe-der-danae-op-83-trv-278/1454310171' WHERE id = 33803 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33803 Die Liebe der Danae (spotify: Strauss: Die Liebe der Danae, Op. 83, TrV 278)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3USBNWKH8HLhKazdRZb6a1' WHERE id = 33803 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33804 Capriccio (apple: R. Strauss: Capriccio)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-capriccio/692115769' WHERE id = 33804 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33804 Capriccio (spotify: Richard Strauss: Capriccio)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5mVWYt3yU4MXvz876edV8T' WHERE id = 33804 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33805 Josephslegende, op. 63 (apple: R. Strauss: Josephs-Legende, Op. 63, TrV 231)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/r-strauss-josephs-legende-op-63-trv-231/1729700422' WHERE id = 33805 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33805 Josephslegende, op. 63 (spotify: R. Strauss: Josephs-Legende, Op. 63, TrV 231)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3EyoiG9Icf70PRGX2swovT' WHERE id = 33805 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33806 Schlagobers (apple: Richard Strauss: Suite from Schlagobers & München)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-suite-from-schlagobers-munchen/1761608264' WHERE id = 33806 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33806 Schlagobers (spotify: Richard Strauss: Suite from Schlagobers & München)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5UmJdEslCdXyUWzMuYvPrB' WHERE id = 33806 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33807 Enoch Arden (apple: Strauss: Enoch Arden)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-enoch-arden/258634353' WHERE id = 33807 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33807 Enoch Arden (spotify: Richard Strauss: Enoch Arden)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/44MgWhyrCRNBT4O6zDDHjk' WHERE id = 33807 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33808 Vier letzte Lieder, AV 150 (spotify: Richard Strauss: Vier letzte Lieder; Metamorphosen; Oboenkonzert)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7JwlxRigKhYIVHnzAJMast' WHERE id = 33808 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33809 8 Gedichte aus »Letzte Blätter« (apple: Richard Strauss Lieder, Op. 10, 22, 27, 29)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder-op-10-22-27-29/1888849072' WHERE id = 33809 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33809 8 Gedichte aus »Letzte Blätter« (spotify: Icon: Lucia Popp)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1k9KxKDnpGpbzN7d1pz5Hb' WHERE id = 33809 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33810 5 Lieder for middle voice and piano (apple: Richard Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder/1140917604' WHERE id = 33810 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33811 6 Lieder (apple: Richard Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder/1140917604' WHERE id = 33811 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33812 6 Lieder aus »Lotosblätter«, op. 19 (apple: Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-lieder/496637533' WHERE id = 33812 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33812 6 Lieder aus »Lotosblätter«, op. 19 (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3YXfXZkbvUXY4uioBswxke' WHERE id = 33812 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33813 Schlichte Weisen (apple: Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-lieder/1650385649' WHERE id = 33813 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33813 Schlichte Weisen (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5hYZiG3xfML5Q42og8mtax' WHERE id = 33813 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33814 Mädchenblumen, op. 22 (apple: Mozart & Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/mozart-strauss-lieder/1731931145' WHERE id = 33814 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33814 Mädchenblumen, op. 22 (spotify: Mozart & Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/0zKuotT3xatskF3qvFRREU' WHERE id = 33814 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33815 2 Lieder, op. 26 (apple: Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-lieder/1650385649' WHERE id = 33815 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33816 4 Lieder, op. 27 (apple: Strauss: 4 Lieder, Op. 27 - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-4-lieder-op-27-ep/1707209087' WHERE id = 33816 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33817 3 Lieder for voice and piano (apple: Richard Strauss Lieder, Op. 10, 22, 27, 29)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder-op-10-22-27-29/1888849072' WHERE id = 33817 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33818 4 Lieder, op. 31 (apple: Andreas Schmidt sings Strauss Songs)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/andreas-schmidt-sings-strauss-songs/808039658' WHERE id = 33818 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33819 5 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33819 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33819 5 Lieder for voice and piano (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5hYZiG3xfML5Q42og8mtax' WHERE id = 33819 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33822 6 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33822 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33823 5 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33823 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33823 5 Lieder for voice and piano (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5hYZiG3xfML5Q42og8mtax' WHERE id = 33823 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33824 5 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33824 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33825 Gesänge älterer deutscher Dichter, for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33825 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33827 5 Gedichte (apple: Richard Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder/1681799731' WHERE id = 33827 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33827 5 Gedichte (spotify: Richard Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4F6V0jWYY8wv6TR5TgwD1u' WHERE id = 33827 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33828 5 Lieder for voice and piano (apple: Richard Strauss: Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-lieder/1681799731' WHERE id = 33828 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33828 5 Lieder for voice and piano (spotify: Richard Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4F6V0jWYY8wv6TR5TgwD1u' WHERE id = 33828 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33830 8 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33830 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33831 6 Lieder for voice and piano (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33831 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33831 6 Lieder for voice and piano (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5hYZiG3xfML5Q42og8mtax' WHERE id = 33831 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33832 Krämerspiegel (apple: Strauss: Krämerspiegel, Op. 66; Lieder)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-kramerspiegel-op-66-lieder/1649859268' WHERE id = 33832 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33832 Krämerspiegel (spotify: Strauss: Krämerspiegel, Op. 66; Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1Hc1DjZstcCan89kWQR3ne' WHERE id = 33832 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33834 6 Lieder nach Gedichten von Clemens Brentano (apple: Strauss: Tod und Verklärung, Don Juan, Sechs Lieder Op. 68)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-tod-und-verklarung-don-juan-sechs-lieder-op-68/1561269546' WHERE id = 33834 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33834 6 Lieder nach Gedichten von Clemens Brentano (spotify: Strauss: Lieder)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3Ur7FyqeaLCNPQ7CpUD1wR' WHERE id = 33834 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33835 5 Kleine Lieder (apple: Richard Strauss: Complete Works for Voice & Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-complete-works-for-voice-piano/879491973' WHERE id = 33835 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33836 Drei Hymnen (apple: Dame Felicity Lott sings Strauss Orchestral Songs, Vol. 2)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/dame-felicity-lott-sings-strauss-orchestral-songs-vol-2/1761345647' WHERE id = 33836 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33836 Drei Hymnen (spotify: Strauss: 3 Hymns - Opera arias)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1TgvB7ur2q17JGKoJhd72A' WHERE id = 33836 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33837 Gesänge des Orients, op. 77 (apple: Richard Strauss: Gesänge des Orients - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-gesange-des-orients-ep/1549572604' WHERE id = 33837 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33837 Gesänge des Orients, op. 77 (spotify: Richard Strauss: Gesänge des Orients)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/51TTy16zpTRPFt8FzbFAVn' WHERE id = 33837 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33838 Deutsche Motette (apple: Bruckner: Mass in E Minor; Strauss,R.: Deutsche Motette)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/deutsche-motette-op-62/1725191757?i=1725191761' WHERE id = 33838 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33838 Deutsche Motette (spotify: Europaeische Chormusik)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1qav440xub5wAF3S8kqZNb' WHERE id = 33838 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33839 2 Gesänge (apple: Strauss - Wagner - Mahler)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-wagner-mahler/501993409' WHERE id = 33839 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33839 2 Gesänge (spotify: Strauss, R: A Cappella Choral Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/56bGJbQ4Zk4FvImeeacho8' WHERE id = 33839 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33840 Wandrers Sturmlied (apple: R. Strauss: Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/wanderes-sturmlied-op-14/298498653?i=298498689' WHERE id = 33840 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33841 Taillefer, ballad for soprano, tenor, baritone, chorus and orchestra (apple: Richard Strauss: Taillefer Op.52 / Divertimento After Couperin Opus 86)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-taillefer-op-52/978819900?i=978820274' WHERE id = 33841 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33841 Taillefer, ballad for soprano, tenor, baritone, chorus and orchestra (spotify: Grande Dame)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3lUCKaKus4HHGtF9p5QGSd' WHERE id = 33841 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 33842 Die Tageszeiten (apple: Strauss: Symphonia Domestica & Die Tageszeiten)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-symphonia-domestica-die-tageszeiten/1749439358' WHERE id = 33842 AND composer_id = 498 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 33842 Die Tageszeiten (spotify: Strauss: Die Tageszeiten, Op. 76)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6fdH9IStPGV9196SAOQ8y6' WHERE id = 33842 AND composer_id = 498 AND (spotify_url IS NULL OR spotify_url = '');
-- 26026 Requiem (spotify: Ligeti : Project Vol.4 - Hamburg Concerto, Double Concerto, Requiem & Ramifications)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/45IvFEcehCUAk3bBpc8eU8' WHERE id = 26026 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 26027 Lux aeterna (spotify: Ligeti: Lux Aeterna)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4Ut4lnRTefpMeMXoZGs1nc' WHERE id = 26027 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 26028 Atmosphères (spotify: Ligeti : Project Vol.2 - Lontano, Atmosphères, Apparitions, San Francisco Polyphony & Concert Românesc)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3HVUDpc6RNoY4d1zF5F287' WHERE id = 26028 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34031 Concert românesc (apple: Ligeti: Violin Concerto, Concert Românesc & Piano Concerto)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-violin-concerto-concert-romanesc-piano-concerto/1800595039' WHERE id = 34031 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34031 Concert românesc (spotify: Ligeti: Violin Concerto - Concert Românesc - Piano Concerto)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3Z5PvU8U0kdg5ey7vq64pm' WHERE id = 34031 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34033 Három Weöres-dal (apple: Ligeti: Nonsense Madrigals, Mysteries of the Macabre, Aventures)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-nonsense-madrigals-mysteries-of-the-macabre-aventures/263085218' WHERE id = 34033 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34033 Három Weöres-dal (spotify: Hungarian Songs: Bartók, Kodály & Ligeti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/14vmuGyhltTjETSZL2rvul' WHERE id = 34033 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34034 Öt Arany-dal (apple: Ligeti: Nonsense Madrigals, Mysteries of the Macabre, Aventures)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-nonsense-madrigals-mysteries-of-the-macabre-aventures/263085218' WHERE id = 34034 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34034 Öt Arany-dal (spotify: Hungarian Songs: Bartók, Kodály & Ligeti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/14vmuGyhltTjETSZL2rvul' WHERE id = 34034 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34036 Six Bagatelles for Wind Quintet (apple: Ligeti: Six Bagatelles, Chamber Concerto & Ten Pieces for Wind Quintet (Live) [Remastered])
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-six-bagatelles-chamber-concerto-ten-pieces-for-wind-quintet-live-remastered/1679780685' WHERE id = 34036 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34036 Six Bagatelles for Wind Quintet (spotify: Ligeti: Six Bagatelles, Chamber Concerto & Ten Pieces for Wind Quintet (Live) [Remastered])
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2FMCLbiLQGh9KdG79vT1TD' WHERE id = 34036 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34037 Sonata for Cello Solo (apple: Ligeti: Sonata for Cello Solo - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-sonata-for-cello-solo-single/452726535' WHERE id = 34037 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34037 Sonata for Cello Solo (spotify: Britten / Bach / Ligeti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1HcY6xHzBQDc9j7U9NxlYz' WHERE id = 34037 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34038 String Quartet no. 1 “Métamorphoses nocturnes” (apple: Bartók, Kurtág, Ligeti: Metamorphosis)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/bartok-kurtag-ligeti-metamorphosis/1596618496' WHERE id = 34038 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34038 String Quartet no. 1 “Métamorphoses nocturnes” (spotify: Ligeti: String Quartets / Ramifications etc)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3ETwMeJXSM9uAhL3p1MRCY' WHERE id = 34038 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34039 Éjszaka és Reggel (apple: Kodály & Ligeti: Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/kodaly-ligeti-choral-works/1609677095' WHERE id = 34039 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34039 Éjszaka és Reggel (spotify: Ligeti: Complete Works for a cappella Choir)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/7Mc05H70bZ02R3SHyP2hO9' WHERE id = 34039 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34040 Apparitions (apple: György Ligeti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/gyorgy-ligeti/1565295251' WHERE id = 34040 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34040 Apparitions (spotify: Ligeti : Project Vol.2 - Lontano, Atmosphères, Apparitions, San Francisco Polyphony & Concert Românesc)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6u6xyeAYduVoORqSEb2y1Y' WHERE id = 34040 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34041 Volumina (apple: Ligeti: Volumina, Organ Study No. 1, Three Pieces for Two Pianos, Aventures, Nouvelles Aventures, Mysteries)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/volumina/1452543149?i=1452543169' WHERE id = 34041 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34041 Volumina (spotify: Ligeti: Volumina; Organ Study No.1; Three Pieces for Two Pianos; Aventures; Nouvelles Aventures; Mysteries)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6XQUpGTXVeKds2zPeSRvzg' WHERE id = 34041 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34042 Poème symphonique for 100 metronomes (apple: Györgi Ligeti: Masterworks)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/po%C3%A8me-symphonique-for-100-metronomes/1459300096?i=1459300218' WHERE id = 34042 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34042 Poème symphonique for 100 metronomes (spotify: György Ligeti Edition, Vol. 5)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/6iL9XTHCWbnntuKR5w2NHZ' WHERE id = 34042 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34043 Aventures (apple: Ligeti: Nonsense Madrigals, Mysteries of the Macabre, Aventures)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/aventures/263085218?i=263085559' WHERE id = 34043 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34043 Aventures (spotify: Ligeti : Project Vol.5 - Ballad & Dance, Cello Sonata, Artikulation, Aventures, Nouvelles Aventures, Musica Ricercata, Big Turtle Fanfare & Régi magyar társas táncok)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4FWycvzHR2mvb7dKP0fkJS' WHERE id = 34043 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34044 Nouvelles aventures (apple: Ligeti: Volumina, Organ Study No. 1, Three Pieces for Two Pianos, Aventures, Nouvelles Aventures, Mysteries)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-volumina-organ-study-no-1-three-pieces-for-two-pianos-aventures-nouvelles-aventures-mysteries/1452543149' WHERE id = 34044 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34044 Nouvelles aventures (spotify: Ligeti : Project Vol.5 - Ballad & Dance, Cello Sonata, Artikulation, Aventures, Nouvelles Aventures, Musica Ricercata, Big Turtle Fanfare & Régi magyar társas táncok)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4RNEzRXL0fjeNQxU65sp8o' WHERE id = 34044 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34045 Concerto for Violoncello and Orchestra (apple: Ligeti: Clear or Cloudy)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-clear-or-cloudy/1452830921' WHERE id = 34045 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34046 Lontano (apple: Stravinsky, I.: Concerto for Piano and Wind Instruments - Zimmermann, B. - Fortner, W.: Symphony - Ligeti, G.: Lontano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/lontano/337266270?i=337266532' WHERE id = 34046 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34046 Lontano (spotify: Ligeti : Project Vol.2 - Lontano, Atmosphères, Apparitions, San Francisco Polyphony & Concert Românesc)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7B8CUAgtqaQXc5zq0yCcUK' WHERE id = 34046 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34047 Continuum (apple: Scarlatti & Ligeti: Continuum)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/continuum/1572109435?i=1572109659' WHERE id = 34047 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34047 Continuum (spotify: Scarlatti & Ligeti: Continuum)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/40E9YThKphJ8HkTCdUbdRv' WHERE id = 34047 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34048 Ten Pieces for Wind Quintet (apple: Ligeti: Six Bagatelles, Chamber Concerto & Ten Pieces for Wind Quintet (Live) [Remastered])
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-six-bagatelles-chamber-concerto-ten-pieces-for-wind-quintet-live-remastered/1679780685' WHERE id = 34048 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34048 Ten Pieces for Wind Quintet (spotify: Ligeti: Six Bagatelles, Chamber Concerto & Ten Pieces for Wind Quintet (Live) [Remastered])
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2FMCLbiLQGh9KdG79vT1TD' WHERE id = 34048 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34049 String Quartet no. 2 (apple: Ligeti: String Quartet No. 2 / Brown: String Quartet / Rosenberg: String Quartet No. 3 (Avantgarde series))
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-string-quartet-no-2-brown-string-quartet-rosenberg-string-quartet-no-3-avantgarde-series/1692900470' WHERE id = 34049 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34049 String Quartet no. 2 (spotify: Metamorphosis Ligeti)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2tqGaJpXBFqu7fIcTkYsTf' WHERE id = 34049 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34050 Two Studies for Organ (apple: Ligeti: Keyboard Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-keyboard-works/404919257' WHERE id = 34050 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34050 Two Studies for Organ (spotify: György Ligeti Edition, Vol. 6: Keyboard Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1aINt1dYLcTyxvEgZcjo8H' WHERE id = 34050 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34051 Ramifications (apple: Ligeti: Ramifications - Single)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ramifications/1676459363?i=1676459364' WHERE id = 34051 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34051 Ramifications (spotify: Ligeti: Ramifications)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1AXxA31rDXD4c0SC5V4ewb' WHERE id = 34051 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34052 Chamber Concerto (apple: Ligeti: Chamber Concerto, Ramifications, String Quartet No. 2 & Aventures)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-chamber-concerto-ramifications-string-quartet-no-2-aventures/1452332537' WHERE id = 34052 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34052 Chamber Concerto (spotify: Ligeti : Project Vol.1 - Melodien, Chamber Concerto, Piano Concerto & Mysteries of the Macabre)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3GBD2UKgcOKfwKjWrcUHFJ' WHERE id = 34052 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34053 Melodien (apple: Ligeti: Melodien; Double Concerto; Chamber Concerto etc.)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/melodien-for-orchestra/1452570731?i=1452570942' WHERE id = 34053 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34053 Melodien (spotify: Ligeti : Project Vol.1 - Melodien, Chamber Concerto, Piano Concerto & Mysteries of the Macabre)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/4XzZTIkXK9OclpzFAPyqnq' WHERE id = 34053 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34054 Double Concerto for Flute and Oboe (apple: Ligeti: Clear or Cloudy)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-clear-or-cloudy/1452830921' WHERE id = 34054 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34054 Double Concerto for Flute and Oboe (spotify: Ligeti: Melodien; Double Concerto for Flute, Oboe and Orchestra; Chamber Concerto for thirteen instrumentalists)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3BtoDLqBkmLU20MOibQmVA' WHERE id = 34054 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34055 Clocks and Clouds (apple: Ligeti: Clocks and Clouds - EP)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clocks-and-clouds/1677521101?i=1677521476' WHERE id = 34055 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34055 Clocks and Clouds (spotify: Ligeti: Clocks and Clouds)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3sATEz0vYQIkVjt3xg2hUZ' WHERE id = 34055 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34056 San Francisco Polyphony (apple: Ligeti: Violin Concerto, Lontano, Atmosphères & San Francisco Polyphony)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/san-francisco-polyphony/704061586?i=704061594' WHERE id = 34056 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34056 San Francisco Polyphony (spotify: Ligeti : Project Vol.2 - Lontano, Atmosphères, Apparitions, San Francisco Polyphony & Concert Românesc)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/7c9ZTnQwP7iGzCE03HCimm' WHERE id = 34056 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34057 Three Pieces (apple: Ligeti: Volumina, Organ Study No. 1, Three Pieces for Two Pianos, Aventures, Nouvelles Aventures, Mysteries)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-volumina-organ-study-no-1-three-pieces-for-two-pianos-aventures-nouvelles-aventures-mysteries/1452543149' WHERE id = 34057 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34057 Three Pieces (spotify: Two Pianos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2TrIe4OicicxU4bCtv5Wic' WHERE id = 34057 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34058 Le Grand Macabre (apple: Ligeti: Le Grand Macabre)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-le-grand-macabre/1054967720' WHERE id = 34058 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34058 Le Grand Macabre (spotify: Ligeti: Le Grand Macabre)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2sYaPxEWUbKywxwGkoSPgq' WHERE id = 34058 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34059 Passacaglia ungherese (apple: György Ligeti: Trio für Violine, Horn u. Klavier / Passacaglia ungherese / Hungarian Rock / Continuum / Monument, Selbstportrait, Bewegung)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/passacaglia-ungherese/1672094842?i=1672095324' WHERE id = 34059 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34059 Passacaglia ungherese (spotify: György Ligeti: Trio für Violine, Horn u. Klavier / Passacaglia ungherese / Hungarian Rock / Continuum / Monument, Selbstportrait, Bewegung)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/3maOxYHIFICZUoNmuaLX6A' WHERE id = 34059 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34060 Hungarian Rock (apple: György Ligeti: Trio für Violine, Horn u. Klavier / Passacaglia ungherese / Hungarian Rock / Continuum / Monument, Selbstportrait, Bewegung)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/hungarian-rock/1672094842?i=1672095337' WHERE id = 34060 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34060 Hungarian Rock (spotify: György Ligeti: Trio für Violine, Horn u. Klavier / Passacaglia ungherese / Hungarian Rock / Continuum / Monument, Selbstportrait, Bewegung)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/1gPgqSbSMMSG8tb3sTxXAs' WHERE id = 34060 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34061 Trio for Violin, Horn, and Piano (apple: Ligeti: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-chamber-music/261728548' WHERE id = 34061 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34061 Trio for Violin, Horn, and Piano (spotify: Andrew Joy: Cor à cor)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2Qh5Yh5cgt9h0qAUpwzJVu' WHERE id = 34061 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34062 Drei Phantasien nach Friedrich Hölderlin (apple: Ligeti: Lux Aeterna)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-lux-aeterna/293897391' WHERE id = 34062 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34062 Drei Phantasien nach Friedrich Hölderlin (spotify: Ligeti: Lux aeterna / Heppener: Im Gestein)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5rhqMIi9NlzqrttUp287kO' WHERE id = 34062 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34063 Magyar etűdök (apple: Ligeti: a Cappella Choral Works)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-a-cappella-choral-works/271423912' WHERE id = 34063 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34063 Magyar etűdök (spotify: Ligeti: Lux æterna and Other Vocal Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/6YQ0audADRefdlSqGb4Irt' WHERE id = 34063 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34065 Concerto for Piano and Orchestra (apple: Bartók & Ligeti)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/bartok-ligeti/1571672878' WHERE id = 34065 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34065 Concerto for Piano and Orchestra (spotify: Haydn & Ligeti: Concertos & Capriccios)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2o7umW5ETVe3kp6TxCVbcH' WHERE id = 34065 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34066 Violin Concerto (apple: Ligeti: Cello Concerto, Violin Concerto & Piano Concerto)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-cello-concerto-violin-concerto-piano-concerto/1452385963' WHERE id = 34066 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34066 Violin Concerto (spotify: Ligeti: Violin Concerto - Concert Românesc - Piano Concerto)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3Z5PvU8U0kdg5ey7vq64pm' WHERE id = 34066 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34067 Nonsense Madrigals (apple: Ligeti: Nonsense Madrigals, Mysteries of the Macabre, Aventures)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-nonsense-madrigals-mysteries-of-the-macabre-aventures/263085218' WHERE id = 34067 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34067 Nonsense Madrigals (spotify: György Ligeti Edition, Vol. 4)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5EZ4lvbLn2ze6l5j0yVA9F' WHERE id = 34067 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34068 Études pour piano, Book 2 (apple: Ligeti: Études for Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-etudes-for-piano/1817587131' WHERE id = 34068 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34068 Études pour piano, Book 2 (spotify: Ligeti: Piano & Harpsichord Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3aOdn7pTzuuXC4AXDaE955' WHERE id = 34068 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34069 Sonata for Solo Viola (apple: Ligeti: Chamber Music)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-chamber-music/272193228' WHERE id = 34069 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34069 Sonata for Solo Viola (spotify: Ligeti, Prokofiev, Roslavets: Works for Viola)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4ZrnKtb9NCcAa8K0eLlw1h' WHERE id = 34069 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34070 Hamburg Concerto (spotify: Ligeti : Project Vol.4 - Hamburg Concerto, Double Concerto, Requiem & Ramifications)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/45IvFEcehCUAk3bBpc8eU8' WHERE id = 34070 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
-- 34072 Études pour piano, Book 3 (apple: Ligeti: Études for Piano)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-etudes-for-piano/1817587131' WHERE id = 34072 AND composer_id = 499 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 34072 Études pour piano, Book 3 (spotify: Ligeti: Piano & Harpsichord Works)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/3aOdn7pTzuuXC4AXDaE955' WHERE id = 34072 AND composer_id = 499 AND (spotify_url IS NULL OR spotify_url = '');
