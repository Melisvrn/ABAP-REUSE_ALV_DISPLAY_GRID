# ABAP-REUSE_ALV_DISPLAY_GRID

Belirli kurallar eşliğinde tablolardan alınan veriler REUSE_ALV_DISPLAY_GRID metodu kullanılarak ekrana püskürtülmüştür.

## Görüntülenmek İstenen ALV Özellikleri:

- Select Screen Ekranında eğer malzeme numarası alanı boş ise bir uyarı popup açılacak.
' UYARI !! Malzeme Numarası Girilmeden Malzeme Görüntülenemez '

- ALV'ye çekilen alanlar SPEME alanı baz alınarak büyükten küçüğe sıralanacak.

- Tahditsiz stoktan bloke stok çıkarılacak ve sonuç internal tablodaki sonuç alanına yazılacak.

- Sonuç alanı gizli olacak ve kullanıcı istediği zaman ALV'de ki düzenle seçeneğinden sonuç alanını alvde görüntüleyebilecek.

- Eğer tahditsiz stoktan bloke stok çıkarıldığında sonuç 0 ve 0 dan küçük ise icon alanında kırmızı trafik lambası yanacak ama sonuç 0 dan büyük ise yeşil trafik lambası yanacak.

## Kullanılacak Tablolar:

:point_right: MARA

:point_right: MARD

:point_right: MARC

## Malzeme Sorgulama Ekranı:

<img src="https://user-images.githubusercontent.com/55049795/147818706-43f7c412-f4d2-424a-ae66-719e80de3df4.png" width="700" >

## Sorgulanan Malzeme Bilgileri:

<img src="https://user-images.githubusercontent.com/55049795/147818803-325f3aa8-5e6f-4208-bb86-df84766ec1b7.png" width="700">







