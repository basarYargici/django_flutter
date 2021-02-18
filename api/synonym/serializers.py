from abc import ABC

from rest_framework import serializers

from .models import SynonymModel


class SynonymModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = SynonymModel
        fields = '__all__'
