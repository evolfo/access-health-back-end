import {
  GET_CAMPAIGNS
} from '../actions/campaignActions';

const initialState = {
  campaigns: []
}

export default function campaignsReducer(state = initialState, action) {
  switch (action.type) {

    case 'GET_CAMPAIGNS':
 	  return {...state, campaigns: action.payload}

    default:
      return state;
  }
}