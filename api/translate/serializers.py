from rest_framework import serializers

from .models import TranslateModel


class TranslateModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = TranslateModel
        fields = '__all__'
