from rest_framework import serializers

from .models import Synonym


class SynonymSerializer(serializers.ModelSerializer):
    class Meta:
        model = Synonym
        fields = '__all__'
