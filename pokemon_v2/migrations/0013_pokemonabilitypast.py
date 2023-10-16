# Generated by Django 2.1.15 on 2023-02-27 15:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("pokemon_v2", "0012_auto_20220626_1402"),
    ]

    operations = [
        migrations.CreateModel(
            name="PokemonAbilityPast",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("is_hidden", models.BooleanField(default=False)),
                ("slot", models.IntegerField()),
                (
                    "ability",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="pokemonabilitypast",
                        to="pokemon_v2.Ability",
                    ),
                ),
                (
                    "generation",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="pokemonabilitypast",
                        to="pokemon_v2.Generation",
                    ),
                ),
                (
                    "pokemon",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="pokemonabilitypast",
                        to="pokemon_v2.Pokemon",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
        ),
    ]
