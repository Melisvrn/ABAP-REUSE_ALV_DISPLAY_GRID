# ABAP-REUSE_ALV_DISPLAY_GRID

Belirli kurallar eşliğinde tablolardan alınan veriler REUSE_ALV_DISPLAY_GRID metodu kullanılarak ekrana püskürtülmüştür.

## Görüntülenmek İstenen ALV Özellikleri:

1-Select Screen Ekranında eğer malzeme numarası alanı boş ise bir uyarı popup açılacak.
' UYARI !! Malzeme Numarası Girilmeden Malzeme Görüntülenemez '

2- ALV'ye çekilen alanlar SPEME alanı baz alınarak büyükten küçüğe sıralanacak.

3-Tahditsiz stoktan bloke stok çıkarılacak ve sonuç internal tablodaki sonuç alanına yazılacak.

4-Sonuç alanı gizli olacak ve kullanıcı istediği zaman ALV'de ki düzenle seçeneğinden sonuç alanını alvde görüntüleyebilecek.

5-Eğer tahditsiz stoktan bloke stok çıkarıldığında sonuç 0 ve 0 dan küçük ise icon alanında kırmızı trafik lambası yanacak ama sonuç 0 dan büyük ise yeşil trafik lambası yanacak.

## Kullanılacak Tablolar:

1-MARA

2-MARD

3-MARC



