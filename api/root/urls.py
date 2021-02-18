from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('synonym/', include('synonym.urls'), name='synonyms'),
    path('translate/', include('translate.urls'), name='translates'),
]
