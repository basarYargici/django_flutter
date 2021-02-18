from rest_framework import viewsets

from .models import SynonymModel
from .serializers import SynonymModelSerializer


class SynonymViewSet(viewsets.ModelViewSet):
    queryset = SynonymModel.objects.all()
    serializer_class = SynonymModelSerializer
