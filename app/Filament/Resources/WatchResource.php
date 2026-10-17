<?php

namespace App\Filament\Resources;

use App\Enums\WatchType;
use App\Filament\Resources\WatchResource\Pages;
use App\Models\Watch;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class WatchResource extends Resource
{
    protected static ?string $model = Watch::class;

    protected static ?int $navigationSort = 20;

    protected static ?string $navigationIcon = 'heroicon-o-eye';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Watch')
                    ->description(__('A Watch defines what to track and when to alert.'))
                    ->schema([
                        Forms\Components\Select::make('type')
                            ->label('Type')
                            ->options(WatchType::class)
                            ->required()
                            ->default(WatchType::Product->value),
                        Forms\Components\TextInput::make('name')
                            ->label('Name')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Toggle::make('is_active')
                            ->label('Active')
                            ->default(true),
                    ])->columns(3),

                Forms\Components\Section::make('Config')
                    ->description(__('Type-specific payload: urls, keywords, filters, top_n, brand, feeds, etc.'))
                    ->schema([
                        Forms\Components\KeyValue::make('config')
                            ->label('Config')
                            ->keyLabel('Key')
                            ->valueLabel('Value')
                            ->reorderable(),
                    ]),

                Forms\Components\Section::make('Rules')
                    ->description(__('max_price, min_pct_below_30d, min_pct_below_90d, record_low_only, store_allowlist (comma), channels (comma), cooldown_minutes.'))
                    ->schema([
                        Forms\Components\KeyValue::make('rules')
                            ->label('Rules')
                            ->keyLabel('Rule')
                            ->valueLabel('Value')
                            ->reorderable(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('type')
                    ->badge()
                    ->sortable(),
                Tables\Columns\IconColumn::make('is_active')
                    ->boolean()
                    ->label('Active'),
                Tables\Columns\TextColumn::make('last_alerted_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->defaultSort('name')
            ->filters([
                Tables\Filters\SelectFilter::make('type')
                    ->options(WatchType::class),
                Tables\Filters\TernaryFilter::make('is_active')
                    ->label('Active'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->modifyQueryUsing(function (Builder $query) {
                $query->currentUser();
            });
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListWatches::route('/'),
            'create' => Pages\CreateWatch::route('/create'),
            'edit' => Pages\EditWatch::route('/{record}/edit'),
        ];
    }
}
