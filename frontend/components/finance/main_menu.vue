<script>
import { FinanceMainMenuGaugeRisk } from '#components';
import MainMenuHistoryRisk from './main-menu/history-risk.vue';

</script>

<template>
    <div class=" text-white mx-auto  grid place-items-center  border-green-500   w-[1200px]  rounded-lg  border-4">
        <h2 class="  mx-auto text-3xl text-green-500">Main menu</h2>
        <FinanceMainMenuHistoryRisk></FinanceMainMenuHistoryRisk>
        <FinanceMainMenuGaugeRisk></FinanceMainMenuGaugeRisk>
    </div>
</template>