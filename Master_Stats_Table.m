let


   
    // STEP 1: Process Dak's Stats


    Source_DakStats = DakStats,

    
    Unpivot_DakStats = Table.UnpivotOtherColumns(
        Source_DakStats,
        {"player_id", "game_id"},
        "Stat_Name",
        "Stat_Value"
    ),

    
    TypeChange_DakStats = Table.TransformColumnTypes(
        Unpivot_DakStats,
        {{"Stat_Value", Int64.Type}}
    ),



    // STEP 2: Process George Pickens' Stats


    
    Source_PickensStats = PickensStats,

    
    Unpivot_PickensStats = Table.UnpivotOtherColumns(
        Source_PickensStats,
        {"player_id", "game_id"},
        "Stat_Name",
        "Stat_Value"
    ),

   
    TypeChange_PickensStats = Table.TransformColumnTypes(
        Unpivot_PickensStats,
        {{"Stat_Value", Int64.Type}}
    ),


  
    // STEP 3: Process Javonte Williams' Stats


 
    Source_JavonteStats = JavonteStats,

   
    Unpivot_JavonteStats = Table.UnpivotOtherColumns(
        Source_JavonteStats,
        {"player_id", "game_id"},
        "Stat_Name",
        "Stat_Value"
    ),

    
    TypeChange_JavonteStats = Table.TransformColumnTypes(
        Unpivot_JavonteStats,
        {{"Stat_Value", Int64.Type}}
    ),


   
    // STEP 4: Combine All Three Tables
    

    
    tablesToCombine_List = {
        TypeChange_DakStats,
        TypeChange_PickensStats,
        TypeChange_JavonteStats
    },

  
    CombinedStatsTable = Table.Combine(tablesToCombine_List),


    
    // STEP 5: Final data Cleanup
    

   
    FinalTypedTable = Table.TransformColumnTypes(
        CombinedStatsTable,
        {
            {"player_id", Int64.Type},
            {"game_id", Int64.Type},
            {"Stat_Name", type text},
            {"Stat_Value", Int64.Type}
        }
    ),

    
    Result = FinalTypedTable

in
    Result