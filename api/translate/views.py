from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets

from .models import Translate
from .serializers import TranslateSerializer


class TranslateViewSet(viewsets.ModelViewSet):
    queryset = Translate.objects.all()
    serializer_class = TranslateSerializer
