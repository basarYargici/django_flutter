from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets

from .models import TranslateModel
from .serializers import TranslateModelSerializer


class TranslateViewSet(viewsets.ModelViewSet):
    queryset = TranslateModel.objects.all()
    serializer_class = TranslateModelSerializer
