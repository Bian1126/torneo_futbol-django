# Generated by Django 5.2.4 on 2025-07-07 18:44

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('torneo', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='inscripcion',
            name='categoria',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.PROTECT, to='torneo.categoria', verbose_name='Categoría'),
        ),
    ]
